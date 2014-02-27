class AddAttachmentsToPage < ActiveRecord::Migration
  def up
    add_attachment :pages, :raw
    add_attachment :pages, :image
  end

  def down
    remove_attachment :page, :raw
    remove_attachment :page, :image
  end
end
