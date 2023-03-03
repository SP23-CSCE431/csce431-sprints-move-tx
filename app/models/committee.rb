class Committee < ApplicationRecord
    # set foreign key for leader member id
    has_one :member
    belongs_to :member, optional: true

    validates :name, presence: true
end
