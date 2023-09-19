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
  
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true, format: { without: /\s/ }

  def set_avatar_filename
    if avatar.attached?
      extension = File.extname(avatar.filename.to_s)
      avatar.blob.update(filename: "#{id}_#{nickname}#{extension}")
    end
  end

end
