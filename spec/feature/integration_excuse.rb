require 'rails_helper'
require "support/test_user"

RSpec.describe "Excuse integration", type: :feature do
    # need to run the oauth before each test 
    include_context 'test user'

    let(:valid_attributes) {
        {
            description: "MyDescription1"
        }
    }

    let(:edit_attributes) {
        {
            description: "MyDescription2"
        }
    }
    
    let(:invalid_attributes) {
        skip("Add a hash of attributes invalid for your model")
    }

    describe "Creation" do
        scenario 'create with valid inputs' do
            visit new_excuse_path
            fill_in "excuse[description]", with: valid_attributes[:description]
            click_on "Create Excuse"
            expect(page).to have_content("Excuse was successfully created")
        end
    end

    describe "Editing" do
        scenario 'update with valid attributes' do
            @temp = Excuse.create!(valid_attributes)
            visit edit_excuse_path(@temp)
            fill_in "excuse[description]", with: edit_attributes[:description]
            click_on "Update Excuse"
            expect(page).to have_content("Excuse was successfully updated")
        end
        
    end

    describe "Deletion" do
        scenario "delete entry" do
            @temp = Excuse.create!(valid_attributes)
            visit excusess_path
            expect(page).to have_content(valid_attributes[:name])
            expect(page).to have_content(valid_attributes[:leader_member_id])

            visit delete_excuse_path(@temp)
            click_on "Delete excuse"
            expect(page).to have_content("Excuse was successfully destroyed.")

        end
    end
end