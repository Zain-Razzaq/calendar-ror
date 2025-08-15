class AddUserAndEventTable < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    create_table :events do |t|
      t.string :title
      t.text :desc
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
