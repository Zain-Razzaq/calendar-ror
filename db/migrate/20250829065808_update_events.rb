class UpdateEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :type, :string
    add_column :events, :price, :float

    create_table :registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :payment_status
      t.float :amount
      t.timestamps
    end
  end
end
