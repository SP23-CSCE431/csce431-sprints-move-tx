require 'rails_helper'

RSpec.describe "member_events/new", type: :view do

  # allow for oauth access
  include_context 'admin oauth for views'
  
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
    assign(:member_event, MemberEvent.new(
      event_id: member.id,
      member_id: member.id,
      approved_status: false,
      approve_by: "MyString"
    ))
  end

  it "renders new member_event form" do
    render

    assert_select "form[action=?][method=?]", member_events_path, "post" do

      assert_select "select[name=?]", "member_event[event_id]"

      assert_select "select[name=?]", "member_event[member_id]"

      assert_select "input[name=?]", "member_event[approved_status]"

<<<<<<< HEAD
      #assert_select "input[name=?]", "member_event[approve_by]"
=======
      assert_select "select[name=?]", "member_event[approve_by]"
>>>>>>> dev
    end
  end
end
