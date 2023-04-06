require 'rails_helper'
require 'support/member_user'

RSpec.describe "Member's View based on position", type: :feature do

  include_context 'member user'

  # Checks pages as if the user is a member not admin
  describe 'Member' do

    # Tests for the member trying to view restricted pages
    it 'Visit Members List' do
      visit members_path
      expect(page).to have_current_path '/'
    end

    it 'Visit Committees' do
      visit committees_path
      expect(page).to have_current_path '/committees'
    end

    it 'Visit Excuses' do
      visit excuses_path
      expect(page).to have_current_path '/excuses'
    end

    # Rainy Test for the member trying ot view the pages
    it 'Visit Members List' do
      visit members_path
      expect(page).to have_no_current_path '/members'
    end

    it 'Visit Committees' do
      visit committees_path
      expect(page).to have_no_current_path '/'
    end

    it 'Visit Excuses' do
      visit excuses_path
      expect(page).to have_no_current_path '/'
    end
  end
end
