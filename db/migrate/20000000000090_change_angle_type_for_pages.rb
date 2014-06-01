class ChangeAngleTypeForPages < ActiveRecord::Migration
  def change
    change_column :pages, :angle, :decimal, precision: 5, scale: 2
  end
end
