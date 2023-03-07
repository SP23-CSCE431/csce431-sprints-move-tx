require 'rails_helper'

RSpec.describe 'members/show', type: :view do
  before(:each) do
    assign(:member, Member.create!(
        name: 'MyName',
        committee: 'MyCommittee',
        position: 'MyPosition',
        civicPoints: 0,
        outreachPoints: 1,
        socialPoints: 2,
        marketingPoints: 3
    ))
  end

  it 'renders attributes' do
    render
    expect(rendered).to match(/MyName/)
    expect(rendered).to match(/MyCommittee/)
    expect(rendered).to match(/MyPosition/)
    expect(rendered).to match(/0/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/6/)  # total points
  end
end