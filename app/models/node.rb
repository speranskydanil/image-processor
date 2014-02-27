class Node < ActiveRecord::Base
  before_destroy :delete_pages

  def delete_pages
    pathes = pages.map { |p| p.image.path.split('/')[0..-4].join('/') }.compact.join(' ')
    `rm -R #{pathes}`
    Page.delete_all id: page_ids
  end

  belongs_to :parent, class_name: 'Node', foreign_key: 'parent_id'
  has_many :children, class_name: 'Node', foreign_key: 'parent_id', dependent: :destroy

  has_many :pages

  belongs_to :status, class_name: 'NodeStatus', foreign_key: 'status_id'

  validates :name, presence: true

  default_scope { order('name asc') }

  scope :with_pages_count, -> do
    select('nodes.*, count(ps.id) AS pages_count')
      .joins('left outer join pages ps on nodes.id = ps.node_id')
      .group('nodes.id')
  end

  before_create :set_status

  def set_status
    self.status ||= NodeStatus.first
  end

  def self.root
    where(parent_id: nil).first
  end

  def self.deep_root(level = 4)
    dependencies = [children: []]

    pointer = dependencies

    level.times do
      pointer.last[:children] = [children: []]
      pointer = pointer.last[:children]
    end

    where(parent_id: nil).includes(dependencies).first
  end

  def root?
    parent.nil?
  end

  def ancestors
    result = []

    cur = self

    while cur
      result << cur
      cur = cur.parent
    end

    result
  end

  def siblings
    if root?
      [self]
    else
      parent.children
    end
  end

  def cancel
    page_ids.dup.each do |page_id|
      Page.find(page_id).cancel
    end
  end

  def duplicate
    page_ids.dup.each do |page_id|
      Page.find(page_id).duplicate
    end
  end

  def generate_zip filename
    dir = Rails.root.join("public/system/nodes/#{id}/zip")
    FileUtils.mkdir_p dir

    tmp_dir = dir.join(filename)
    FileUtils.rm_rf tmp_dir
    FileUtils.mkdir_p tmp_dir

    file = dir.join(filename + '.zip')
    FileUtils.rm_f file

    pages.each do |page|
      FileUtils.cp page.image.path(:original), tmp_dir.join(page.position.to_s + '.jpg')
    end

    `cd #{dir}; zip -r #{filename}.zip #{filename}`
    FileUtils.rm_rf tmp_dir
  end

  def remove_zip filename
    FileUtils.rm_f Rails.root.join("public/system/nodes/#{id}/zip").join(filename + '.zip')
  end

  def to_param
    "#{id} #{name}".parameterize
  end
end

