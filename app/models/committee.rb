class Committee < ApplicationRecord
    # set foreign key for leader member id!
    has_one :member
    belongs_to :member, optional: true

    validates :name, presence: true
    validate :formatting

    # ensure that correct input formats are used
    def formatting
        # name only has letters, numbers, apostraphes, and space characters
        errors.add(:name, 'name cannot have non-word characters') if !name.nil? && !name.match?(/^[\w'\s]*$/)
    end
end
