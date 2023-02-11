require 'rails_helper'

RSpec.describe "member_events/show", type: :view do
  before(:each) do
    assign(:member_event, MemberEvent.create!(
      event_id: 2,
      member_id: 3,
      approved_status: false,
      approve_by: "Approve By"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Approve By/)
  end
end
