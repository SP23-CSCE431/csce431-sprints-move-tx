require 'rails_helper'

RSpec.describe 'members/index', type: :view do

  before(:each) do
    assign(:members, [
      Member.create!(
        name: 'MyString',
        status: true
      ),
      Member.create!(
        name: 'MyString',
        status: true
      )
    ])
  end

  it 'renders a list of member_events' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('MyString'.to_s), count: 2
  end
end