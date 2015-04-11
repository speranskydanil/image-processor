class AddCountersToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :pages_total, :integer, default: 0
    add_column :nodes, :pages_processed_total, :integer, default: 0
    add_column :nodes, :pages_unprocessed_total, :integer, default: 0
    add_column :nodes, :children_total, :integer, default: 0
    add_column :nodes, :children_processed_total, :integer, default: 0
    add_column :nodes, :children_unprocessed_total, :integer, default: 0

    add_column :pages, :processed, :boolean, default: false
  end
end
