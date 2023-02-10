require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      name: "MyString",
      point_type: "MyString",
      event_type: "MyString",
      phrase: "MyString"
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[point_type]"

      assert_select "input[name=?]", "event[event_type]"

      assert_select "input[name=?]", "event[phrase]"
    end
  end
end
