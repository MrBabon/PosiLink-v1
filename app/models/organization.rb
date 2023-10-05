class Organization < ApplicationRecord

  CATEGORIES = %w(écologie culture sport santé éducation humanitaire).freeze

  has_one_attached :photo
  has_many :events, dependent: :destroy

  has_many :follows, as: :followable, dependent: :destroy
  has_many :followers, through: :follows, source: 'follower', source_type: 'User'

  validates :category, inclusion: { in: %w(écologie culture sport santé éducation humanitaire), message: "Catégorie invalide" }


  include PgSearch::Model
  pg_search_scope :search_by_organization,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }

  def custom_followers
    User.joins(:follows).where(follows: { followable: self })
  end
end
