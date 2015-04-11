class ChangeAdminUser < ActiveRecord::Migration
  def change
    User.find_by(email: 'info@inforost.org').try :destroy
    User.create(email: 'admin@inforost.org', password: 'InfoRostAdmin2009')
  end
end
