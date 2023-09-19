class ChangePrivateToChatrooms < ActiveRecord::Migration[7.0]
  def change
    change_column :chatrooms, :private, :boolean, default: true
  end
end
