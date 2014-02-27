class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.integer :status_id
      t.integer :n_sided, default: 1

      t.timestamps
    end

    add_index :nodes, :name
    add_index :nodes, :description, length: 20
    add_index :nodes, :parent_id
    add_index :nodes, :status_id
  end
end
