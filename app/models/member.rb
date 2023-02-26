class Member < ApplicationRecord
  has_many :events, through: :member_events
  has_many :member_events, dependent: :destroy

  validates :name, presence: true

  # sets foreign key (admin) for member
  has_one :admin
  belongs_to :admin, optional: true
end
