# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_role_based_on_is_organization
  before_save :set_avatar_filename
  before_destroy :cleanup_dependent_records
  
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :chatrooms, through: :participants
  
  has_many :participations, dependent: :destroy
  has_many :events, through: :participations
  has_many :follows, foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :follows, source: 'followable', source_type: 'Organization'
  
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attribute :is_organization, :boolean, default: false
  
        #  Les validation #
  validates :nickname, presence: true, format: { without: /\s/ }

  def set_role_based_on_is_organization
    self.role = is_organization ? "association" : "bénévole"
  end

  def set_avatar_filename
    if avatar.attached?
      extension = File.extname(avatar.filename.to_s)
      avatar.blob.update(filename: "#{id}_#{nickname}#{extension}")
    end
  end

  def following?(organization)
    follows.exists?(followable: organization)
  end

  def follow(organization)
    follows.create(followable: organization)
  end

  def unfollow(organization)
    follow = follows.find_by(followable: organization)
    if follow
      follow.destroy!
      true
    else
      false
    end
  end
  
  private

  def cleanup_dependent_records
    participations.destroy_all
    messages.destroy_all
    follows.destroy_all
  end


end
