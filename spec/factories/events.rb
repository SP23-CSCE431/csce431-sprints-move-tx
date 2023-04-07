FactoryBot.define do
  factory :event do
    name { 'Name' }
    date { Date.today }
    point_type { 'Outreach' }
    event_type { 'Service' }
    phrase { 'Phrase' }
  end
end
