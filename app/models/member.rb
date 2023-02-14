class Member < ApplicationRecord
  has_many :events, through: :member_events
  has_many :member_events, dependent: :destroy

  validates :name, :committee, :position, :civicPoints, :outreachPoints, :socialPoints, :marketingPoints, :totalPoints,  presence: true
end
