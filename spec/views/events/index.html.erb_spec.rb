require 'rails_helper'

RSpec.describe 'events/index', type: :view do

  include_context 'admin oauth for views'

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
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new(events[0].name.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(events[0].point_type.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(events[0].event_type.to_s), count: 2
  end
end
