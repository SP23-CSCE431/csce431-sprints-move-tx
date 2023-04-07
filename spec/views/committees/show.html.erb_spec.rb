require 'rails_helper'
require 'support/test_user'

RSpec.describe 'committees/show', type: :view do
  include_context 'admin oauth for views'

  before(:each) do
    newmember = Member.create!(
      name: 'John'
    )
    assign(:committee, Committee.create!(
      name: 'Name',
      member_id: newmember.id
    ))
  end

  # it 'renders attributes in <p>' do
  #   render
  #   expect(rendered).to match(/Name/)
  # end
end
