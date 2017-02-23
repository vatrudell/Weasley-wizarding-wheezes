class User < ApplicationRecord
  has_secure_password

  validates :username, :password, :email, presence: true
  validates :username, :email, uniqueness: true
end
