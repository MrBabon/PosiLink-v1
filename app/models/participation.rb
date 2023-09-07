class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  
  delegate :start_time, to: :event

  def self.participation_for(user, event)
    Participation.find_by(user: user, event: event)
  end

  def time
    "#{start_time.strftime('%I:%M %p')}"
  end
  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end
end
