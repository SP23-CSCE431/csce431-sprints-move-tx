class MemberEvent < ApplicationRecord
  belongs_to :member
  belongs_to :event

  has_one_attached :file

  before_save do
    self.approved_status = false if approved_status.nil?
    if (approved_status == true) then
      self.approve_date = DateTime.now if approve_date.blank?
    else
      self.approve_date = nil
    end
  end


end
