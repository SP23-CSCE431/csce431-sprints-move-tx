require 'rails_helper'
require "support/test_user"

RSpec.describe "Home integration:", type: :feature do

  include_context 'test user'

  describe "Home Page:" do
    # Making sure that the home page has the correct information
    scenario 'Information on Page' do
      visit root_path
      expect(page).to have_content("Your Information:")
      expect(page).to have_content("Committee")
      expect(page).to have_content("Position")
      expect(page).to have_content("Civic Points")
      expect(page).to have_content("Outreach Points")
      expect(page).to have_content("Social Points")
      expect(page).to have_content("Marketing Points")
      expect(page).to have_content("Total Points")
    end
  end
end
