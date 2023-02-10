require 'rails_helper'

RSpec.describe "excuses/show", type: :view do
  before(:each) do
    assign(:excuse, Excuse.create!(
      description: "MyText",
      file: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
