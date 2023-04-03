class Committee < ApplicationRecord
    # set foreign key for leader member id!
    has_one :member
    belongs_to :member, optional: true

    validates :name, presence: true
    validate :formatting

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
