class Member < ApplicationRecord
  has_many :events, through: :member_events
  has_many :member_events, dependent: :destroy

  validates :name, presence: true
  has_one :admin

  
  belongs_to :admin
end
