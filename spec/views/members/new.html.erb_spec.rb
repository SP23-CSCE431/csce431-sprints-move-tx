require 'rails_helper'

RSpec.describe 'members/new', type: :view do

  include_context 'admin oauth for views'
  
  let(:committee1) {
    Committee.create!(
      name: "MyCommittee"
    )
  }

  before(:each) do
    assign(:member, Member.new(
      name: 'MyName',
      committee_id: committee1.id,
      position: 'MyPosition',
      civicPoints: 0,
      outreachPoints: 1,
      socialPoints: 2,
      marketingPoints: 3,
      totalPoints: 4
    ))
  end

  it 'renders new member form' do
    render

    assert_select 'form[action=?][method=?]', members_path, 'post' do

      assert_select 'input[name=?]', 'member[name]'

      assert_select 'select[name=?]', 'member[committee_id]'

      assert_select 'input[name=?]', 'member[position]'

      assert_select 'input[name=?]', 'member[civicPoints]'

      assert_select 'input[name=?]', 'member[outreachPoints]'

      assert_select 'input[name=?]', 'member[socialPoints]'

      assert_select 'input[name=?]', 'member[marketingPoints]'

      #assert_select "input[name=?]", "member[totalPoints]"
      
    end
  end
end
