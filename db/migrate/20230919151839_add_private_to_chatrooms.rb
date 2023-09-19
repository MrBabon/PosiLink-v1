class AddPrivateToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_column :chatrooms, :private, :boolean
  end
end
