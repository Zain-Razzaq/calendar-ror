class ChangeTypeOfColumns < ActiveRecord::Migration[8.0]
  def change
    change_column :events, :start_time, :time
    change_column :events, :end_time, :time
  end
end
