class User < ApplicationRecord
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
end
