class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :payment_status, presence: true, inclusion: { in: Registration.payment_statuses.keys }
  validates :amount, presence: true, numericality: { greater_than: -1 }

  enum :payment_status, { pending: "pending", paid: "paid", failed: "failed" }
end