require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  let(:member) {
    Member.create!(
      name: "MyName",
      committee: "MyCommittee",
      position: "MyPosition",
      civicPoints: 1,
      outreachPoints: 1,
      socialPoints: 1,
      marketingPoints: 1,
      totalPoints: 4
    )
  }

  before(:each) do
    assign(:member, member)
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(member), "post" do

      assert_select "input[name=?]", "member[name]"

      assert_select "input[name=?]", "member[committee]"

      assert_select "input[name=?]", "member[position]"

      assert_select "input[name=?]", "member[civicPoints]"

      assert_select "input[name=?]", "member[outreachPoints]"

      assert_select "input[name=?]", "member[socialPoints]"

      assert_select "input[name=?]", "member[marketingPoints]"

      assert_select "input[name=?]", "member[totalPoints]"

    end
  end
end