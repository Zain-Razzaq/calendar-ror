class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :payment_status, presence: true, inclusion: { in: %w[pending paid failed] }
  validates :amount, presence: true, numericality: { greater_than: -1 }
end
