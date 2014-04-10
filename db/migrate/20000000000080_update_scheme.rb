class UpdateScheme < ActiveRecord::Migration
  def change
    change_column :delayed_jobs, :created_at, :datetime, null: true
    change_column :delayed_jobs, :updated_at, :datetime, null: true

    change_column :node_statuses, :created_at, :datetime, null: true
    change_column :node_statuses, :updated_at, :datetime, null: true

    change_column :nodes, :created_at, :datetime, null: true
    change_column :nodes, :updated_at, :datetime, null: true

    change_column :pages, :created_at, :datetime, null: true
    change_column :pages, :updated_at, :datetime, null: true

    change_column :users, :created_at, :datetime, null: true
    change_column :users, :updated_at, :datetime, null: true
  end
end
