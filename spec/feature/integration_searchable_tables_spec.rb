require 'rails_helper'
require 'support/test_user'

RSpec.describe 'Searching Integration:', type: :feature do

  # need to run the oauth before each test
  include_context 'test user'

  # Create committee for testing sorting committee
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

  let!(:committee3) {
    Committee.create!(
      name: 'MyCommittee3'
    )
  }

  # Creation of members with alternating values
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

  let!(:valid_attributes3) {
    {
      name: 'Name3',
      committee_id: committee1.id,
      position: 'MyPosition3',
      civicPoints: 10011,
      outreachPoints: 10011,
      socialPoints: 10015,
      marketingPoints: 10013,
      totalPoints: 40050
    }
  }

  # Sorting table with two members; Sunny Tests
  describe 'Three Members' do
    it 'Searching members with similar names' do
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

      visit new_member_path

      fill_in 'member[name]',             with: valid_attributes3[:name]
      select committee3.name,             from: 'member[committee_id]'
      fill_in 'member[position]',         with: valid_attributes3[:position]
      fill_in 'member[civicPoints]',      with: valid_attributes3[:civicPoints]
      fill_in 'member[outreachPoints]',   with: valid_attributes3[:outreachPoints]
      fill_in 'member[socialPoints]',     with: valid_attributes3[:socialPoints]
      fill_in 'member[marketingPoints]',  with: valid_attributes3[:marketingPoints]
      click_on 'Create Member'

      visit members_path
      # Searching for valid names
      fill_in 'search', with: 'MyName'
      click_on 'Search'
      expect(page).to have_content('MyName1')

      click_on 'Back to Members'

      fill_in 'search', with: 'MyName1'
      click_on 'Search'
      expect(page).to have_content('MyName1')

      click_on 'Back to Members'

      fill_in 'search', with: 'MyName2'
      click_on 'Search'
      expect(page).to have_content('MyName2')

      click_on 'Back to Members'
      # Searching for invalid names
      fill_in 'search', with: 'myname'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: 'MyNameDoesNotExist'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: '#$@@$!#@!'
      click_on 'Search'
      expect(page).to have_content('Members')
    end

    it 'Searching members with different names' do
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

      fill_in 'member[name]',             with: valid_attributes3[:name]
      select committee3.name,             from: 'member[committee_id]'
      fill_in 'member[position]',         with: valid_attributes3[:position]
      fill_in 'member[civicPoints]',      with: valid_attributes3[:civicPoints]
      fill_in 'member[outreachPoints]',   with: valid_attributes3[:outreachPoints]
      fill_in 'member[socialPoints]',     with: valid_attributes3[:socialPoints]
      fill_in 'member[marketingPoints]',  with: valid_attributes3[:marketingPoints]
      click_on 'Create Member'

      visit members_path
      # Searching for valid names
      fill_in 'search', with: 'MyN'
      click_on 'Search'
      expect(page).to have_content('MyName1')

      click_on 'Back to Members'

      fill_in 'search', with: 'MyName1'
      click_on 'Search'
      expect(page).to have_content('MyName1')

      click_on 'Back to Members'

      fill_in 'search', with: 'me3'
      click_on 'Search'
      expect(page).to have_content('Name3')

      click_on 'Back to Members'

      fill_in 'search', with: 'Name3'
      click_on 'Search'
      expect(page).to have_content('Name3')

      click_on 'Back to Members'
      # Searching for invalid names
      fill_in 'search', with: 'name3'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: 'MyNameDoesNotExist'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: '#$@@$!#@!'
      click_on 'Search'
      expect(page).to have_content('Members')

    end

    it 'Searching members that do not exist' do
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

      visit new_member_path

      fill_in 'member[name]',             with: valid_attributes3[:name]
      select committee3.name,             from: 'member[committee_id]'
      fill_in 'member[position]',         with: valid_attributes3[:position]
      fill_in 'member[civicPoints]',      with: valid_attributes3[:civicPoints]
      fill_in 'member[outreachPoints]',   with: valid_attributes3[:outreachPoints]
      fill_in 'member[socialPoints]',     with: valid_attributes3[:socialPoints]
      fill_in 'member[marketingPoints]',  with: valid_attributes3[:marketingPoints]
      click_on 'Create Member'

      visit members_path
      # Searching for invalid names
      fill_in 'search', with: 'MyNameDoesNotExist'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: '#$@@$!#@!'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: '{Delete Data}'
      click_on 'Search'
      expect(page).to have_content('Members')

      fill_in 'search', with: 'fdfadsf'
      click_on 'Search'
      expect(page).to have_content('Members')
    end
  end
end
