require 'rails_helper'

RSpec.describe 'excuses/edit', type: :view do
  
  let!(:member) { Member.create!(name: 'MyName1') }
  let!(:event) do
    Event.create!(
      name: 'Park clean up',
      date: Date.parse('2022-12-15'),
      point_type: 'Outreach',
      event_type: 'Service'
    )
  end

  let(:excuse) {
    Excuse.create!(
      description: 'MyText',
      event_id: event.id,
      member_id: member.id,
      file: nil
    )
  }

  before(:each) do
    assign(:excuse, excuse)
  end

  it 'renders the edit excuse form' do
    render

    assert_select 'form[action=?][method=?]', excuse_path(excuse), 'post' do

      assert_select 'textarea[name=?]', 'excuse[description]'

      assert_select 'input[name=?]', 'excuse[file]'
    end
  end
end
