class User < ApplicationRecord

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :username, format: { with: /\A[[:alnum:]_]+\z/ }
end
