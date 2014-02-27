class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :position, default: 0
      t.integer :node_id

      t.string :status, default: 'free'

      t.integer :angle
      t.integer :x1
      t.integer :y1
      t.integer :x2
      t.integer :y2

      t.timestamps
    end

    add_index :pages, :position
    add_index :pages, :node_id
  end
end
