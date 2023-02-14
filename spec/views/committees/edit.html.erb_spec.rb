require 'rails_helper'

RSpec.describe "committees/edit", type: :view do
  let(:committee) {
    Committee.create!(
      name: "MyString",
      leader_member_id: 1
    )
  }

  before(:each) do
    assign(:committee, committee)
  end

  it "renders the edit committee form" do
    render

    assert_select "form[action=?][method=?]", committee_path(committee), "post" do

      assert_select "input[name=?]", "committee[name]"

      assert_select "input[name=?]", "committee[leader_member_id]"
    end
  end
end
