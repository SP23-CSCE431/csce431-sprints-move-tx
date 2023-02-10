require 'rails_helper'

RSpec.describe "committees/show", type: :view do
  before(:each) do
    assign(:committee, Committee.create!(
      name: "Name",
      leader_member_id: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
