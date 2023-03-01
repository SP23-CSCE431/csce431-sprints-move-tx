require 'rails_helper'

RSpec.describe "committees/edit", type: :view do
  let(:committee) {
    Committee.create!(
      name: "MyString",
    )
  }

  before(:each) do
    assign(:committee, committee)
  end

  it "renders the edit committee form" do
    render

    assert_select "form[action=?][method=?]", committee_path(committee), "post" do

      assert_select "input[name=?]", "committee[name]"

      assert_select "select[name=?]", "committee[member_id]"
    end
  end
end
