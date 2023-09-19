class RemoveUserIdsFromChatrooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :chatrooms, :user1_id, :bigint
    remove_column :chatrooms, :user2_id, :bigint
  end
end
