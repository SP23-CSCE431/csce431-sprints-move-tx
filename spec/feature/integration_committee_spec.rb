require 'rails_helper'

RSpec.describe "Committee integration", type: :feature do
    let(:valid_attributes) {
        {
            name: "MyName1",
            leader_member_id: 12345
        }
    }

    let(:edit_attributes) {
        {
            name: "MyName2",
            leader_member_id: 54321
        }
    }
    
    let(:invalid_attributes) {
        skip("Add a hash of attributes invalid for your model")
    }

    describe "Creation" do
        scenario 'create with valid inputs' do
            visit new_committee_path
            fill_in "committee[name]", with: valid_attributes[:name]
            fill_in "committee[leader_member_id]", with: valid_attributes[:leader_member_id]
            click_on "Create Committee"
            visit committees_path
            expect(page).to have_content(valid_attributes[:name])
            expect(page).to have_content(valid_attributes[:leader_member_id])
        end
    end

    describe "Editing" do
        scenario 'update name' do
            @temp = Committee.create!(valid_attributes)
            visit committee_url(@temp)
            expect(page).to have_content(valid_attributes[:name])
            visit edit_committee_path(@temp)
            fill_in "committee[name]", with: edit_attributes[:name]
            click_on "Update Committee"
            visit committee_url(@temp)
            expect(page).not_to have_content(valid_attributes[:name])
            expect(page).to have_content(edit_attributes[:name])
        end
        
        scenario 'update leader_member_id' do
            @temp = Committee.create!(valid_attributes)
            visit committee_url(@temp)
            expect(page).to have_content(valid_attributes[:leader_member_id])
            visit edit_committee_path(@temp)
            fill_in "committee[leader_member_id]", with: edit_attributes[:leader_member_id]
            click_on "Update Committee"
            visit committee_url(@temp)
            expect(page).not_to have_content(valid_attributes[:leader_member_id])
            expect(page).to have_content(edit_attributes[:leader_member_id])
        end
        
    end

    describe "Deletion" do
        scenario "delete entry" do
            @temp = Committee.create!(valid_attributes)
            visit committees_path
            expect(page).to have_content(valid_attributes[:name])
            expect(page).to have_content(valid_attributes[:leader_member_id])

            visit delete_committee_path(@temp)
            click_on "Delete committee"
            visit committees_path
            expect(page).not_to have_content(valid_attributes[:name])
            expect(page).not_to have_content(valid_attributes[:leader_member_id])

        end
    end

end