require 'rails_helper'

RSpec.describe 'excuses/index', type: :view do

  let!(:member) { Member.create!(name: 'MyName1') }
  let!(:event) do
    Event.create!(
      name: 'Park clean up',
      date: Date.parse('2022-12-15'),
      point_type: 'Outreach',
      event_type: 'Service'
    )
  end

  before(:each) do
    assign(:excuses, [
      Excuse.create!(
      description: 'MyText',
      event_id: event.id,
      member_id: member.id,
      file: nil
      ),
      Excuse.create!(
        description: 'MyText',
        event_id: event.id,
        member_id: member.id,
        file: nil
      )
    ])
  end

  it 'renders a list of excuses' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 0
  end
end
