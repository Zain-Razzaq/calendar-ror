class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :desc, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than: -1 }
  validates :type, presence: true, inclusion: { in: Event.types.keys }
  validate :valid_times

  enum :type, { free: "free", paid: "paid" }

  private

  def valid_times
    if start_time.nil?
      errors.add(:start_time, "must be present")
      return
    end
    if end_time.nil?
      errors.add(:end_time, "must be present")
      return
    end
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
