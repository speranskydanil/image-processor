class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles

  default_scope { order(email: :asc) }
end
