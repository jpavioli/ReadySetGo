class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :user_type, presence: true

end
