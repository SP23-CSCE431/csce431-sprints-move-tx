class Event < ApplicationRecord
  has_many :events, through: :member_events
  has_many :member_events, dependent: :destroy

  validates :date, :name, :event_type, presence: true
  validate :meeting_phrase
  validate :service_point_type
  validate :non_event_point_type
  validate :formatting


  private
  # if there is a meeting needs to be phrase 
  def meeting_phrase
    if (event_type == 'Meeting') && phrase.blank?
      errors.add(:phrase, "can't be blank when there is a meeting")
    end
  end

  def service_point_type
    if (event_type == 'Service') && point_type.blank?
      errors.add(:point_type, "point type can't be blank when there is a service")
    end
  end
  
  # if there is a non-event needs to have point type
  def non_event_point_type
    if (event_type == 'Personal/Non-Event') && point_type.blank?
      errors.add(:point_type, "point type can't be blank when there is a non-event")
    end
  end

  # ensure that correct input formats are used
  def formatting
    # name only has letters, numbers, apostraphes, and space characters
    unless name.nil?
      unless name.match?(/^[\w'\s]*$/)
        errors.add(:name, "name cannot have non-word characters")
      end
    end
  end
end
