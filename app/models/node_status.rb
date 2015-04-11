class NodeStatus < ActiveRecord::Base
  has_many :nodes, foreign_key: 'status_id'

  validates :name, :position, presence: true

  default_scope { order(position: :asc) }

  after_create :move_to_the_end

  def move_to_the_end
    update_attributes(position: NodeStatus.maximum(:position).to_i + 1)
  end
end
