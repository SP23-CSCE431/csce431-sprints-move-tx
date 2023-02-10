require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    assign(:event, Event.create!(
      name: "Name",
      point_type: "Point Type",
      event_type: "Event Type",
      phrase: "Phrase"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Point Type/)
    expect(rendered).to match(/Event Type/)
    expect(rendered).to match(/Phrase/)
  end
end
