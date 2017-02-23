class User < ApplicationRecord
  has_secure_password

  validates :username, :first_name, :last_name, :password, :email, presence: true
  validates :username, :email, uniqueness: true
end
