require 'rails_helper'

RSpec.describe "excuses/index", type: :view do
  before(:each) do
    assign(:excuses, [
      Excuse.create!(
        description: "MyText",
        file: nil
      ),
      Excuse.create!(
        description: "MyText",
        file: nil
      )
    ])
  end

  it "renders a list of excuses" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    #assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
