require 'rails_helper'

RSpec.describe "member_events/edit", type: :view do
  
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
      event_type: "Service",
    )
  }
  
  let(:member_event) {
    MemberEvent.create!(
      event_id: event.id,
      member_id: member.id,
      approved_status: false,
      approve_by: "MyString"
    )
  }

  before(:each) do
    assign(:member, member)
    assign(:event, event)
    assign(:member_event, member_event)
  end

  it "renders the edit member_event form" do
    @version = "1"

    render

    assert_select "form[action=?][method=?]", member_event_path(member_event), "post" do

      assert_select "select[name=?]", "member_event[event_id]"

      assert_select "input[name=?]", "member_event[approved_status]"

      assert_select "select[name=?]", "member_event[approve_by]"
    end
  end
end
