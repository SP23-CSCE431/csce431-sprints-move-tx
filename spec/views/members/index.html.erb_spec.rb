require 'rails_helper'
require 'support/test_user'

RSpec.describe 'members/index', type: :view do
  include_context 'admin oauth for views'

  before do
    $members = [
      Member.create!(
        name: 'MyString2',
        status: true
      ),
      Member.create!(
        name: 'MyString2',
        status: true
      )
    ]
  end

  it 'renders a list of member_events' do
    render
    puts rendered
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('MyString2'.to_s), count: 2
  end
end