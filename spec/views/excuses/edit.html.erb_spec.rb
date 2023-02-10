require 'rails_helper'

RSpec.describe "excuses/edit", type: :view do
  let(:excuse) {
    Excuse.create!(
      description: "MyText",
      file: nil
    )
  }

  before(:each) do
    assign(:excuse, excuse)
  end

  it "renders the edit excuse form" do
    render

    assert_select "form[action=?][method=?]", excuse_path(excuse), "post" do

      assert_select "textarea[name=?]", "excuse[description]"

      assert_select "input[name=?]", "excuse[file]"
    end
  end
end
