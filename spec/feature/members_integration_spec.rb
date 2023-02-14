# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a new member', type: :feature do
  scenario 'valid inputs' do
    visit new_member_path
    fill_in 'Name', with: 'Pauline Wade'
    fill_in 'Committee', with: 'Teachers'
    fill_in 'Position', with: 'Professor'
    fill_in 'Civicpoints', with: 1
    fill_in 'Outreachpoints', with: 2
    fill_in 'Socialpoints', with: 3
    fill_in 'Marketingpoints', with: 4
    fill_in 'Totalpoints', with: 10
    click_on 'Create Member'
    visit members_path
    expect(page).to have_content("Pauline Wade")
  end

  scenario 'invalid inputs' do
    visit new_member_path
    fill_in 'Name', with: ''
    click_on 'Create Member'
    expect(page).to have_content("Name can't be blank")
  end
end
