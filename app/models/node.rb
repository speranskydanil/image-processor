require 'zip'

class Node < ActiveRecord::Base
  before_destroy :delete_pages

  def delete_pages
    pathes = pages.map(&:path).join(' ')
    `rm -R #{pathes}`
    Page.delete_all id: page_ids
  end

  belongs_to :parent, class_name: 'Node', foreign_key: 'parent_id'
  has_many :children, class_name: 'Node', foreign_key: 'parent_id', dependent: :destroy

  has_many :pages

  belongs_to :status, class_name: 'NodeStatus', foreign_key: 'status_id'

  validates :name, presence: true

  default_scope { order(name: :asc) }

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

  has_attached_file :archive
  validates_attachment_content_type :archive, content_type: %w(application/zip)

  def generate_archive
    name = "node_#{id}_#{SecureRandom.hex}.zip"
    path = Rails.root.join('public/system', name)

    Zip::File.open(path, Zip::File::CREATE) do |zipfile|
      pages.each do |page|
        zipfile.add("#{page.position}.jpg", page.image.path)
      end
    end

    self.archive = File.open(path)
    self.save
    File.delete(path)
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  Counter = Struct.new 'Counter',
                       :pages_total,
                       :pages_processed_total,
                       :pages_unprocessed_total,
                       :children_total,
                       :children_processed_total,
                       :children_unprocessed_total

  def update_counters
    counter = Counter.new pages.count,
                          processed_pages.count,
                          unprocessed_pages.count,
                          children.count,
                          processed_children.count,
                          unprocessed_children.count

    children.map(&:update_counters).each do |c|
      counter.pages_total             += c.pages_total
      counter.pages_processed_total   += c.pages_processed_total
      counter.pages_unprocessed_total += c.pages_unprocessed_total
    end

    update counter.to_h
    counter
  end

  def processed_children
    children.where(status_id: [5, 6])
  end

  def unprocessed_children
    children.where(status_id: [1, 2, 3, 4])
  end

  def processed_pages
    pages.where(processed: true)
  end

  def unprocessed_pages
    pages.where(processed: false)
  end
end

