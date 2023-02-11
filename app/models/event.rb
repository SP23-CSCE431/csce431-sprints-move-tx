class Event < ApplicationRecord
  has_many :events, through: :member_events
  has_many :member_events, dependent: :destroy

  validates :date, :name, :event_type, presence: true
end
