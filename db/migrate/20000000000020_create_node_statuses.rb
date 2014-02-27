class CreateNodeStatuses < ActiveRecord::Migration
  def change
    create_table :node_statuses do |t|
      t.string :name
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :node_statuses, :position
  end
end
