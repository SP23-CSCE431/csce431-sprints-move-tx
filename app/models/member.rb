class Member < ApplicationRecord
  has_many :events, through: :member_events
  has_many :member_events, dependent: :destroy

  validates :name, presence: true

  validate :formatting

  # sets foreign key (admin) for member
  has_one :admin
  belongs_to :admin, optional: true

  # set foreign key (committee) for member
  has_one :committee, dependent: :nullify
  belongs_to :committee, optional: true

  # when saving, update points and total points
  before_save do
    self.civicPoints      = 0 if civicPoints.nil?     || civicPoints < 0
    self.outreachPoints   = 0 if outreachPoints.nil?  || outreachPoints < 0
    self.socialPoints     = 0 if socialPoints.nil?    || socialPoints < 0
    self.marketingPoints  = 0 if marketingPoints.nil? || marketingPoints < 0
    self.totalPoints = self.civicPoints + self.outreachPoints + self.socialPoints + self.marketingPoints
  end

  private

  # ensure that correct input formats are used
  def formatting
    # name only has letters, numbers, apostraphes, and space characters
    errors.add(:name, 'name cannot have non-word characters') if !name.nil? && !name.match?(/^[\w'\s]*$/)

    # position only has letters, numbers, apostraphes, and space characters
    errors.add(:position, 'position cannot have non-word characters') if !position.nil? && !position.match?(/^[\w'\s]*$/)
  end
end
