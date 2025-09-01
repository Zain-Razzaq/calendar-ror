class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :desc, presence: true, length: { minimum: 5 }
  validates :price, presence: true, numericality: { greater_than: -1 }
  validates :event_type, presence: true, inclusion: { in: %w[free paid] }
  validate :valid_times
  before_validation :set_price_for_free_events

  def registered_users_count
    registrations.count
  end

  def user_registered?(user)
    return false unless user
    registrations.exists?(user: user, payment_status: "paid")
  end

  private

  def set_price_for_free_events
    if event_type == "free"
      self.price = 0
    end
  end

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
