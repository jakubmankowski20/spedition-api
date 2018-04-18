class User < ApplicationRecord
  self.table_name = "auth_users"

  has_secure_password

  # Associate user with orders
  has_many :orders, foreign_key: :create_user_id

  # Validations
  validates_presence_of :name, :surname, :email, :phone_number, :password_digest
end