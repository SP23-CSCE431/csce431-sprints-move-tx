require 'rails_helper'

RSpec.describe "member_events/new", type: :view do
  before(:each) do
    assign(:member_event, MemberEvent.new(
      event_id: 1,
      member_id: 1,
      approved_status: false,
      approve_by: "MyString"
    ))
  end

  it "renders new member_event form" do
    render

    assert_select "form[action=?][method=?]", member_events_path, "post" do

      assert_select "input[name=?]", "member_event[event_id]"

      assert_select "input[name=?]", "member_event[member_id]"

      assert_select "input[name=?]", "member_event[approved_status]"

      assert_select "input[name=?]", "member_event[approve_by]"
    end
  end
end
