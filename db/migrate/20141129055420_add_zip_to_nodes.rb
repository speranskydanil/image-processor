class AddZipToNodes < ActiveRecord::Migration
  def up
    add_attachment :nodes, :archive
  end

  def down
    remove_attachment :nodes, :archive
  end
end
