require 'rails_helper'
require 'support/test_user'



RSpec.describe 'member_events/index', type: :view do
  # allow for oauth access


  
  include_context 'admin oauth for views'
  let(:committee1) {
    Committee.create!(
      name: 'MyCommittee'
    )
  }

  let(:member) {
    Member.create!(
      name: 'john',
      committee_id: committee1.id,
      position: 'President',
      civicPoints: 1,
      outreachPoints: 1,
      socialPoints: 1,
      marketingPoints: 1,
      totalPoints: 4
    )
  }

  let(:event) {
    Event.create!(
      name: 'MyEventString',
      date: Date.parse('01-01-2023'),
      point_type: 'MyString',
      event_type: 'Service',
    )
  }

  let(:current_admin) {
    current_admin.create()
  }

  before(:each) do
    assign(:member, member)
    assign(:event, event)
    assign(:member_events, [
      MemberEvent.create!(
        event_id: event.id,
        member_id: member.id,
        approved_status: true,
        approve_by: 'wayland'
      ),
      MemberEvent.create!(
        event_id: event.id,
        member_id: member.id,
        approved_status: true,
        approve_by: 'wayland'
      )
    ])
    assign(:service_events , [
      MemberEvent.create!(
        event_id: event.id,
        member_id: member.id,
        approved_status: true,
        approve_by: 'wayland'
      ),
      MemberEvent.create!(
        event_id: event.id,
        member_id: member.id,
        approved_status: true,
        approve_by: 'wayland'
      )
    ])
  end

  it 'renders a list of member_events' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new(event[:name].to_s), count: 2
    assert_select cell_selector, text: Regexp.new(true.to_s), count: 2
    assert_select cell_selector, text: 'wayland', count: 2
  end
end