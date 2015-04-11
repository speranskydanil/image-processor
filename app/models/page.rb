def spawn_wait(cmd)
  pid = Process.spawn(cmd)
  Process.wait(pid)
end

class Page < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :node

  validates :node_id, :position, :image, presence: true

  default_scope { order(position: :asc) }

  after_create :move_to_the_end, :save_raw

  def move_to_the_end
    update_attributes(position: node.pages.maximum(:position).to_i + 1)
  end

  def save_raw
    self.raw = File.open(self.image.path) unless self.raw.exists?
    self.save
  end

  def path
    Rails.root + "public/system/pages/#{node_id}/#{id}"
  end

  # paperclip

  Paperclip.interpolates :node_id do |attachment, style|
    attachment.instance.node_id
  end

  has_attached_file :raw,
    url: '/system/:class/:node_id/:id/:attachment/:style/:hash.:extension',
    path: ':rails_root/public/system/:class/:node_id/:id/:attachment/:style/:hash.:extension',
    hash_secret: 'd0206fbc28efed440e96cdaf4c91c715'

  validates_attachment_content_type :raw, content_type: %w(image/jpeg image/jpg image/png)

  has_attached_file :image,
    styles: {
      large:   ['656x1400', :jpg],
      x_small: ['164x400', :jpg],
      preview: ['50x80', :jpg]
    },

    convert_options: {
      all:     '-format jpg -quality 80',
      large:   '-define jpeg:size=1312x2600',
      x_small: '-define jpeg:size=328x600',
      preview: '-define jpeg:size=100x160'
    },

    url: '/system/:class/:node_id/:id/:attachment/:style/:hash.:extension',
    path: ':rails_root/public/system/:class/:node_id/:id/:attachment/:style/:hash.:extension',

    hash_secret: 'd0206fbc28efed440e96cdaf4c91c715'

  validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png image/tiff)

  # helpers

  def width(style = :original)
    geometry(style).width
  end

  def height(style = :original)
    geometry(style).height
  end

  def geometry(style = :original)
    Paperclip::Geometry.from_file(image.path(style))
  end

  # main methods

  def process(angle, x1, y1, x2, y2)
    update_attribute :status, 'busy'
    delay.process_action(angle, x1, y1, x2, y2)
  end

  def process_action(angle, x1, y1, x2, y2)
    size = ((width ** 2 + height ** 2) ** 0.5).round
    size_l = ((width(:large) ** 2 + height(:large) ** 2) ** 0.5).round

    x1 = (x1 * size / size_l).round
    y1 = (y1 * size / size_l).round
    x2 = (x2 * size / size_l).round
    y2 = (y2 * size / size_l).round

    spawn_wait "mogrify -rotate #{angle} #{image.path}"
    spawn_wait "mogrify -bordercolor '#fff' -border #{(size - width) / 2}x#{(size - height) / 2} #{image.path}"
    spawn_wait "mogrify -crop #{x2-x1}x#{y2-y1}+#{x1}+#{y1} #{image.path}"

    image.reprocess!

    update_attributes status: 'free', processed: true
  end

  def cancel
    update_attribute :status, 'busy'
    delay.cancel_action
  end

  def cancel_action
    self.image = File.open(self.raw.path)
    self.save

    update_attributes status: 'free', processed: false
  end

  def duplicate
    delay.insert nil
  end

  def insert image
    raw = image || File.open(self.raw.path)
    image = image || File.open(self.image.path)

    page = Page.create node: node, raw: raw, image: image
    Page.where('node_id = ? and position > ?', node_id, position).update_all('position = position + 1')
    page.update_attribute :position, position + 1

    page
  end

  def free?
    status == 'free'
  end

  # other

  def siblings
    node.pages
  end

  def prev
    siblings[(siblings.index(self) - 1) % siblings.length]
  end

  def prev_all
    siblings[0...siblings.index(self)]
  end

  def next
    siblings[(siblings.index(self) + 1) % siblings.length]
  end

  def next_all
    siblings[(siblings.index(self) + 1)..-1]
  end

  def hash_for_fileupload
    {
      name: read_attribute(:image_file_name),
      size: read_attribute(:image_file_size),
      url: image.url(:original),
      thumbnail_url: image.url(:preview),
      delete_url: page_path(self),
      delete_type: 'DELETE'
    }
  end

  def title
    "#{I18n.t('pages.page')} #{siblings.index(self) + 1}"
  end

  def index_number
    node.pages.index(self) + 1
  end
end

