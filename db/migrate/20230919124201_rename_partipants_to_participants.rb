class RenamePartipantsToParticipants < ActiveRecord::Migration[7.0]
  def change
    rename_table :partipants, :participants
  end
end
