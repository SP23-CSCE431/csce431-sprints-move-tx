require 'rails_helper'

RSpec.describe 'member_events/show', type: :view do
  let(:committee1) {
    Committee.create!(
      name: "MyCommittee"
    )
  }

  let(:member) {
    Member.create!(
      name: 'MyMemberName',
      committee_id: committee1.id,
      position: 'MyPosition',
      civicPoints: 1,
      outreachPoints: 1,
      socialPoints: 1,
      marketingPoints: 1,
      totalPoints: 4
    )
  }

  let(:event) {
    Event.create!(
      name: 'MyEventName',
      date: Date.parse('01-01-2023'),
      point_type: 'MyString',
      event_type: 'Service',
    )
  }

  before(:each) do
    assign(:member, member)
    assign(:event, event)
    assign(:member_event, MemberEvent.create!(
      event_id: event.id,
      member_id: member.id,
      approved_status: false,
      approve_by: 'Approve By'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/MyMemberName/)
    expect(rendered).to match(/MyEventName/)
    expect(rendered).to match(/false/)
    #expect(rendered).to match(/Approve By/)
  end
end
