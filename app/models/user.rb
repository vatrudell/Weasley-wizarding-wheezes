class User < ApplicationRecord
  has_secure_password

  has_many :orders

  validates :username, :first_name, :last_name, :password, :email, :address, presence: true
  validates :username, :email, uniqueness: true

  enum role: [:default, :admin]
end
