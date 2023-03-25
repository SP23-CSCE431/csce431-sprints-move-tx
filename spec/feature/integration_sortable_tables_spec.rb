require 'rails_helper'
require 'support/test_user'

RSpec.describe 'Navigation Integration:', type: :feature do

  # need to run the oauth before each test
  include_context 'test user'

  #Create committee for testing sorting committee
  let!(:committee1) {
      Committee.create!(
          name: 'MyCommittee1'
      )
  }
  let!(:committee2) {
      Committee.create!(
          name: 'MyCommittee2'
      )
  }

  #Creation of members with alternating values
  let!(:valid_attributes1) {
      {
          name: 'MyName1',
          committee_id: committee2.id,
          position: 'MyPosition1',
          civicPoints: 10010,
          outreachPoints: 10012,
          socialPoints: 10012,
          marketingPoints: 10014,
          totalPoints: 40048
      }
  }
  let!(:valid_attributes2) {
      {
          name: 'MyName2',
          committee_id: committee1.id,
          position: 'MyPosition2',
          civicPoints: 10011,
          outreachPoints: 10011,
          socialPoints: 10015,
          marketingPoints: 10013,
          totalPoints: 40050
      }
  }

  # Sorting table with two members; Sunny Tests
  describe 'Two members alternating sorting' do
    scenario 'Two members with alternating values' do
      # Creating members
      visit new_member_path

      fill_in 'member[name]',             with: valid_attributes1[:name]
      select committee2.name,             from: 'member[committee_id]'
      fill_in 'member[position]',         with: valid_attributes1[:position]
      fill_in 'member[civicPoints]',      with: valid_attributes1[:civicPoints]
      fill_in 'member[outreachPoints]',   with: valid_attributes1[:outreachPoints]
      fill_in 'member[socialPoints]',     with: valid_attributes1[:socialPoints]
      fill_in 'member[marketingPoints]',  with: valid_attributes1[:marketingPoints]
      click_on 'Create Member'

      visit new_member_path

      fill_in 'member[name]',             with: valid_attributes2[:name]
      select committee1.name,             from: 'member[committee_id]'
      fill_in 'member[position]',         with: valid_attributes2[:position]
      fill_in 'member[civicPoints]',      with: valid_attributes2[:civicPoints]
      fill_in 'member[outreachPoints]',   with: valid_attributes2[:outreachPoints]
      fill_in 'member[socialPoints]',     with: valid_attributes2[:socialPoints]
      fill_in 'member[marketingPoints]',  with: valid_attributes2[:marketingPoints]
      click_on 'Create Member'

      visit members_path

      click_on "Member Name"

      within_table('Member list') do
        expect(page).to have_text valid_attributes1[:name]
        click_on 'Member Name'
        expect(page).to have_text valid_attributes2[:name]
        click_on 'Committee'
        expect(page).to have_text valid_attributes2[:committee]
        click_on 'Position'
        expect(page).to have_text valid_attributes1[:position]
      end
    end
  end
end
