class Event < ApplicationRecord
    validates :date, :name, :event_type, presence: true
end
