class MemberEvent < ApplicationRecord
  belongs_to :member
  belongs_to :event

  # checks if phrase is equal to is event phrase, wont check if there is no event 
  validate :phrase_matches_event_phrase
  has_one_attached :file

  # when saving, update values given approval status
  before_save do
    self.approved_status = false if approved_status.nil?
    if (approved_status == true) then
      self.approve_date = DateTime.now if approve_date.blank?
    else
      self.approve_date = nil
    end
  end

  # checks to see if phrase matches the meetings phrase
  def phrase_matches_event_phrase
    unless self.event.nil?
      if self.event.event_type == 'Meeting'
        errors.add(:phrase, 'Entered wrong password try again') unless self.phrase == event.phrase
      end
    end
  end

  # function that checks if the event exists. 
  def event_exists?
    event.present?
  end

end
