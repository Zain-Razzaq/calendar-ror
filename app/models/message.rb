class Message < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :desc).limit(20).reverse }

  validates :content, presence: true
  validates :user, presence: true
end
