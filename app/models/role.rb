class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true

  default_scope { order(name: :asc) }

  serialize :right_ids

  def rights
    Right.instances.select { |r| right_ids.include? r.id }
  end

  after_initialize :set_rights

  def set_rights
    self.right_ids ||= []
  end

  before_save :prepare_rights

  def prepare_rights
    self.right_ids = right_ids.map(&:to_i)
  end
end
