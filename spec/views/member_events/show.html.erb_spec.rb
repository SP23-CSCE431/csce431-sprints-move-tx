require 'rails_helper'

RSpec.describe "member_events/show", type: :view do
  
  let(:member) {
    Member.create!(
      name: "MyName",
      committee: "MyCommittee",
      position: "MyPosition",
      civicPoints: 1,
      outreachPoints: 1,
      socialPoints: 1,
      marketingPoints: 1,
      totalPoints: 4
    )
  }

  let(:event) {
    Event.create!(
      name: "MyString",
      date: Date.parse("01-01-2023"),
      point_type: "MyString",
      event_type: "MyString",
      phrase: "MyString"
    )
  }

  before(:each) do
    assign(:member, member)
    assign(:event, event)
    assign(:member_event, MemberEvent.create!(
      event_id: event.id,
      member_id: member.id,
      approved_status: false,
      approve_by: "Approve By"
    ))
  end

  it "renders attributes in <p>" do
    render
    #expect(rendered).to match(/2/)
    #expect(rendered).to match(/3/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Approve By/)
  end
end