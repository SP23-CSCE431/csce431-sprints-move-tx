require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        name: 'Name',
        date: Date.parse('01-01-2023'),
        point_type: 'Point Type',
        event_type: 'Event Type',
        phrase: 'Phrase'
      ),
      Event.create!(
        name: 'Name',
        date: Date.parse('01-01-2023'),
        point_type: 'Point Type',
        event_type: 'Event Type',
        phrase: 'Phrase'
      )
    ])
  end

  it 'renders a list of events' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Point Type'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Event Type'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Phrase'.to_s), count: 2
  end
end
