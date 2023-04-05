FactoryBot.define do
  factory :event do
    name { 'Name' }
    date { Date.today }
    point_type { 'Outreac' }
    event_type { 'Service' }
    phrase { 'Phrase' }
  end
end
