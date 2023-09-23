class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :participants, dependent: :destroy
    has_many :users, through: :participants
    include PgSearch::Model
    pg_search_scope :search_by_nickname,
                    associated_against: {
                      participants: [:user]
                    },
                    using: {
                      tsearch: { prefix: true }
                    }
    def private?
        participants.count == 2
      end
end
