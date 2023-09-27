class Organization < ApplicationRecord
  has_one_attached :photo
  has_many :events, dependent: :destroy

  has_many :follows, as: :followable, dependent: :destroy
  has_many :followers, through: :follows, source: 'follower', source_type: 'User'


  include PgSearch::Model
  pg_search_scope :search_by_organization,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }

  def followers
    User.joins(:follows).where(follows: { followable: self })
  end
end
