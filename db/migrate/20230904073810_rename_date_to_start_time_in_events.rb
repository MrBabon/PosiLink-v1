class RenameDateToStartTimeInEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :date, :start_time

  end
end
