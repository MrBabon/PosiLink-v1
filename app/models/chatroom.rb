class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :participants, dependent: :destroy
    has_many :users, through: :participants

    def private?
        participants.count == 2 # Une conversation privée a deux participants
      end
end
