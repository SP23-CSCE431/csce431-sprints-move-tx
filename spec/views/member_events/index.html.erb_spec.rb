require 'rails_helper'

RSpec.describe "member_events/index", type: :view do
  before(:each) do
    assign(:member_events, [
      MemberEvent.create!(
        event_id: 2,
        member_id: 3,
        approved_status: false,
        approve_by: "Approve By"
      ),
      MemberEvent.create!(
        event_id: 2,
        member_id: 3,
        approved_status: false,
        approve_by: "Approve By"
      )
    ])
  end

  it "renders a list of member_events" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Approve By".to_s), count: 2
  end
end
