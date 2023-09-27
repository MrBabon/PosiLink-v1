# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :set_avatar_filename
  
  has_many :messages
  has_many :participants
  has_many :chatrooms, through: :participants
  
  has_many :participations
  has_many :events, through: :participations
  has_many :follows, foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :follows, source: 'followable', source_type: 'Organization'
  
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
        #  Les validation #
  validates :nickname, presence: true, format: { without: /\s/ }



  def set_avatar_filename
    if avatar.attached?
      extension = File.extname(avatar.filename.to_s)
      avatar.blob.update(filename: "#{id}_#{nickname}#{extension}")
    end
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

  def following?(organization)
    follows.exists?(followable: organization)
  end

end
