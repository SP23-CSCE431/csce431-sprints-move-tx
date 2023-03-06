require 'rails_helper'

RSpec.describe 'excuses/new', type: :view do
  before(:each) do
    assign(:excuse, Excuse.new(
      description: 'MyText',
      file: nil
    ))
  end

  it 'renders new excuse form' do
    render

    assert_select 'form[action=?][method=?]', excuses_path, 'post' do

      assert_select 'textarea[name=?]', 'excuse[description]'

      assert_select 'input[name=?]', 'excuse[file]'
    end
  end
end
