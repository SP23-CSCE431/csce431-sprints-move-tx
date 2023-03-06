require 'rails_helper'

RSpec.describe 'committees/new', type: :view do
  before(:each) do
    assign(:committee, Committee.new(
      name: 'MyString',
      member_id: 1
    ))
  end

  it 'renders new committee form' do
    render

    assert_select 'form[action=?][method=?]', committees_path, 'post' do

      assert_select 'input[name=?]', 'committee[name]'
      
      assert_select 'select[name=?]', 'committee[member_id]'
    end
  end
end
