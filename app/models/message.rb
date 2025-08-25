class Message < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :asc).limit(20) }

  validates :content, presence: true
  validates :user, presence: true
end
