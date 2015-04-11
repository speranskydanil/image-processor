class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.text :right_ids, limit: 1000

      t.timestamps
    end

    create_table(:roles_users, id: false) do |t|
      t.integer :role_id
      t.integer :user_id
    end

    add_index :roles_users, :role_id
    add_index :roles_users, :user_id

    role = Role.create name: 'admin', right_ids: Right.instances.map(&:id)

    User.all.each do |user|
      user.roles = [role]
      user.save
    end
  end
end
