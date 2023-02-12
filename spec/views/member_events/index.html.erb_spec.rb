require 'rails_helper'

RSpec.describe "member_events/index", type: :view do
  
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
    assign(:member_events, [
      MemberEvent.create!(
        event_id: event.id,
        member_id: member.id,
        approved_status: false,
        approve_by: "Approve By"
      ),
      MemberEvent.create!(
        event_id: event.id,
        member_id: member.id,
        approved_status: false,
        approve_by: "Approve By"
      )
    ])
  end

  it "renders a list of member_events" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    #assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    #assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Approve By".to_s), count: 2
  end
end
