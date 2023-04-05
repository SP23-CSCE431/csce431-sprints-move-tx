require 'rails_helper'
require 'support/test_user'

RSpec.describe 'events/show', type: :view do
  include_context 'admin oauth for views'

  before(:each) do
    assign(:event, Event.create!(
      name: 'Name',
      date: Date.parse('01-01-2023'),
      point_type: 'Outreach',
      event_type: 'Service'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Service/)
    expect(rendered).to match(/Outreach/)
  end
end
