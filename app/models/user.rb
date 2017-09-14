class User < ApplicationRecord
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: /\A[a-zA-Z0-9\_]+\Z/ }
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
