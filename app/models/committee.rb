class Committee < ApplicationRecord
    # set foreign key for leader member id
    has_one :member

    validates :name, :leader_member_id, presence: true
end
