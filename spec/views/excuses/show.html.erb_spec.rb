require 'rails_helper'

RSpec.describe 'excuses/show', type: :view do

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
    assign(:excuse, Excuse.create!(
      description: 'MyText',
      event_id: event.id,
      member_id: member.id,
      file: nil
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
