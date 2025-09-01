class AddStripeSessionIdToRegistrations < ActiveRecord::Migration[8.0]
  def change
    add_column :registrations, :stripe_session_id, :string
  end
end
