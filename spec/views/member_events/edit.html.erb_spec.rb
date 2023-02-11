require 'rails_helper'

RSpec.describe "member_events/edit", type: :view do
  let(:member_event) {
    MemberEvent.create!(
      event_id: 1,
      member_id: 1,
      approved_status: false,
      approve_by: "MyString"
    )
  }

  before(:each) do
    assign(:member_event, member_event)
  end

  it "renders the edit member_event form" do
    render

    assert_select "form[action=?][method=?]", member_event_path(member_event), "post" do

      assert_select "input[name=?]", "member_event[event_id]"

      assert_select "input[name=?]", "member_event[member_id]"

      assert_select "input[name=?]", "member_event[approved_status]"

      assert_select "input[name=?]", "member_event[approve_by]"
    end
  end
end
