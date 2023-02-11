class MemberEvent < ApplicationRecord
  belongs_to :member
  belongs_to :event

  has_one_attached :file
end
