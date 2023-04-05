require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  it 'renders a list of events' do
    events = create_list(:event, 2)
    page = 1
    per_page = 2
    total_entries = 4
    paginated_events = WillPaginate::Collection.create(page, per_page, total_entries) do |pager|
      pager.replace(events)
    end

    assign(:events, paginated_events)
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Point Type'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Event Type'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Phrase'.to_s), count: 2
  end
end
