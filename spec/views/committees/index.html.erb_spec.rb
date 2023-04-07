require 'rails_helper'
require 'support/test_user'

RSpec.describe 'committees/index', type: :view do
  include_context 'admin oauth for views'

  before(:each) do
    newmember = Member.create!(
      name: 'John'
    )
    assign(:committees, [
      Committee.create!(
        name: 'CommitteeName',
        member_id: newmember.id
      ),
      Committee.create!(
        name: 'CommitteeName',
        member_id: newmember.id
      )
    ])
  end

  it 'renders a list of committees' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('CommitteeName'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('John'), count: 2
  end
end
