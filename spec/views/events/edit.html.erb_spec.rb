require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  let(:event) {
    Event.create!(
      name: "MyString",
      date: Date.parse("01-01-2023"),
      point_type: "MyString",
      event_type: "MyString",
      phrase: "MyString"
    )
  }

  before(:each) do
    assign(:event, event)
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(event), "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[point_type]"

      assert_select "input[name=?]", "event[event_type]"

      assert_select "input[name=?]", "event[phrase]"
    end
  end
end
