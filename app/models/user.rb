class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable  

  default_scope { order('email asc') }
end
