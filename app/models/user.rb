class User < ApplicationRecord
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  validates :name, presence: true
  validates :email, format: { with: EMAIL_FORMAT }, uniqueness: true, presence: true
end
