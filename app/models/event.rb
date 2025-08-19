class Event < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :desc, presence: true, length: { minimum: 5 }
end
