require 'rails_helper'
require 'support/member_user'

RSpec.describe "Member's View based on position", type: :feature do

  include_context 'member user'

  # Checks pages as if the user is a member not admin
  describe 'Member' do

    # Tests for the member trying to view restricted pages
    scenario 'Visit Members List' do
      visit members_path
      expect(current_path).to eq '/'
    end

    scenario 'Visit Committees' do
      visit committees_path
      expect(current_path).to eq '/'
      # moved from duplicate setup (and duplicate named) test for rainy day case
      expect(current_path).not_to eq '/committees'
    end

    scenario 'Visit Excuses' do
      visit excuses_path
      expect(current_path).to eq '/excuses'
      # moved from duplicate setup (and duplicate named) test for rainy day case
      expect(current_path).not_to eq '/'
    end

    # Rainy Test for the member trying ot view the pages
    scenario 'Visit Members List' do
      visit members_path
      expect(current_path).not_to eq '/members'
    end
  end
end
