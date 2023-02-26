require 'rails_helper'

RSpec.describe "Navigation Integration:", type: :feature do

  describe "Navigation:" do
    # Home button returns home
    scenario 'Navigation bar: Home' do
      visit root_path
      click_on 'Home'
      expect(current_path).to eq '/'
    end
    # Member List displays member list
    scenario 'Navigation bar: Member List' do
      visit root_path
      click_on 'Member List'
      expect(current_path).to eq '/members'
    end
    # Committess button goes to committees
    scenario 'Navigation bar: Committees' do
      visit root_path
      click_on 'Committees'
      expect(current_path).to eq '/committees'
    end
    # Events buttons goes to Events
    scenario 'Navigation bar: Events' do
      visit root_path
      click_on 'Events'
      expect(current_path).to eq '/events'
    end
    # Excuses button goes to Excuses
    scenario 'Navigation bar: Excuses' do
      visit root_path
      click_on 'Excuses'
      expect(current_path).to eq '/excuses'
    end
    # Member Events button goes to Member Events
    scenario 'Navigation bar: Member Events' do
      visit root_path
      click_on 'Member Events'
      expect(current_path).to eq '/member_events'
    end
    # Events button does not go to home
    scenario 'Navigation bar: Rainy Day' do
      visit root_path
      click_on 'Events'
      expect(current_path).not_to eq '/'
    end
  end
end
