class Member < ApplicationRecord
  validates :name, presence: true
end
