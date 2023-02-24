require 'rails_helper'

RSpec.describe "Navigation Integration:", type: :feature do

  describe "Navigation:" do
    scenario 'Navigation bar: Home' do
      visit root_path
      click_on 'Home'
      expect(current_path).to eq '/'
    end

    scenario 'Navigation bar: Member List' do
      visit root_path
      click_on 'Member List'
      expect(current_path).to eq '/members'
    end

    scenario 'Navigation bar: Committees' do
      visit root_path
      click_on 'Committees'
      expect(current_path).to eq '/committees'
    end

    scenario 'Navigation bar: Events' do
      visit root_path
      click_on 'Events'
      expect(current_path).to eq '/events'
    end

    scenario 'Navigation bar: Excuses' do
      visit root_path
      click_on 'Excuses'
      expect(current_path).to eq '/excuses'
    end

    scenario 'Navigation bar: Member Events' do
      visit root_path
      click_on 'Member Events'
      expect(current_path).to eq '/member_events'
    end
  end
end
