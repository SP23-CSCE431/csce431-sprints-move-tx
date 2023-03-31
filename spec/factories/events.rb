FactoryBot.define do
    factory :event do
      name { "Name" }
      date { Date.today }
      point_type { "Point Type" }
      event_type { "Event Type" }
      phrase { "Phrase" }
    end
  end