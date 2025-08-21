class Event < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :desc, presence: true, length: { minimum: 5 }

  validate :valid_times

  private

  def valid_times
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
