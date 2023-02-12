require 'rails_helper'

RSpec.describe "members integration", type: :feature do
    let(:valid_attributes) {
        {
            name: "MyName1",
            committee: "MyCommittee1",
            position: "MyPosition1",
            civicPoints: 10010,
            outreachPoints: 10011,
            socialPoints: 10012,
            marketingPoints: 10013,
            totalPoints: 10014
        }
    }

    let(:edit_attributes) {
        {
            name: "MyName2",
            committee: "MyCommittee2",
            position: "MyPosition2",
            civicPoints: 10090,
            outreachPoints: 10091,
            socialPoints: 10092,
            marketingPoints: 10093,
            totalPoints: 10094
        }
    }

    let(:invalid_attributes) {
        {
            name: nil
        }
    }

    describe "Creation" do
        scenario 'create with valid inputs' do
            visit new_member_path
            fill_in "member[name]",             with: valid_attributes[:name]
            fill_in "member[committee]",        with: valid_attributes[:committee]
            fill_in "member[position]",         with: valid_attributes[:position]
            fill_in "member[civicPoints]",      with: valid_attributes[:civicPoints]
            fill_in "member[outreachPoints]",   with: valid_attributes[:outreachPoints]
            fill_in "member[socialPoints]",     with: valid_attributes[:socialPoints]
            fill_in "member[marketingPoints]",  with: valid_attributes[:marketingPoints]
            fill_in "member[totalPoints]",      with: valid_attributes[:totalPoints]
            click_on "Create Member"
            visit members_path
            expect(page).to have_content(valid_attributes[:name])
            expect(page).to have_content(valid_attributes[:committee])
            expect(page).to have_content(valid_attributes[:position])
            expect(page).to have_content(valid_attributes[:civicPoints])
            expect(page).to have_content(valid_attributes[:outreachPoints])
            expect(page).to have_content(valid_attributes[:socialPoints])
            expect(page).to have_content(valid_attributes[:marketingPoints])
            expect(page).to have_content(valid_attributes[:totalPoints])
        end

        scenario 'create with invalid name' do
            visit new_member_path
            fill_in "member[name]",             with: invalid_attributes[:name]
            fill_in "member[committee]",        with: valid_attributes[:committee]
            fill_in "member[position]",         with: valid_attributes[:position]
            fill_in "member[civicPoints]",      with: valid_attributes[:civicPoints]
            fill_in "member[outreachPoints]",   with: valid_attributes[:outreachPoints]
            fill_in "member[socialPoints]",     with: valid_attributes[:socialPoints]
            fill_in "member[marketingPoints]",  with: valid_attributes[:marketingPoints]
            fill_in "member[totalPoints]",      with: valid_attributes[:totalPoints]
            click_on "Create Member"
            visit members_path
            expect(page).not_to have_content(valid_attributes[:committee])
            expect(page).not_to have_content(valid_attributes[:position])
            expect(page).not_to have_content(valid_attributes[:civicPoints])
            expect(page).not_to have_content(valid_attributes[:outreachPoints])
            expect(page).not_to have_content(valid_attributes[:socialPoints])
            expect(page).not_to have_content(valid_attributes[:marketingPoints])
            expect(page).not_to have_content(valid_attributes[:totalPoints])
        end
    end

    describe "Editing" do
        scenario 'update name' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:name])
            visit edit_member_path(@temp)
            fill_in "member[name]", with: edit_attributes[:name]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:name])
            expect(page).to have_content(edit_attributes[:name])
        end
        #######################################
        scenario 'update committee' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:committee])
            visit edit_member_path(@temp)
            fill_in "member[committee]", with: edit_attributes[:committee]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:committee])
            expect(page).to have_content(edit_attributes[:committee])
        end

        scenario 'update position' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:position])
            visit edit_member_path(@temp)
            fill_in "member[position]", with: edit_attributes[:position]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:position])
            expect(page).to have_content(edit_attributes[:position])
        end

        scenario 'update civicPoints' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:civicPoints])
            visit edit_member_path(@temp)
            fill_in "member[civicPoints]", with: edit_attributes[:civicPoints]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:civicPoints])
            expect(page).to have_content(edit_attributes[:civicPoints])
        end

        scenario 'update outreachPoints' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:outreachPoints])
            visit edit_member_path(@temp)
            fill_in "member[outreachPoints]", with: edit_attributes[:outreachPoints]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:outreachPoints])
            expect(page).to have_content(edit_attributes[:outreachPoints])
        end

        scenario 'update socialPoints' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:socialPoints])
            visit edit_member_path(@temp)
            fill_in "member[socialPoints]", with: edit_attributes[:socialPoints]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:socialPoints])
            expect(page).to have_content(edit_attributes[:socialPoints])
        end

        scenario 'update marketingPoints' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:marketingPoints])
            visit edit_member_path(@temp)
            fill_in "member[marketingPoints]", with: edit_attributes[:marketingPoints]
            click_on "Edit Member"
            visit member_url(@temp)
            expect(page).not_to have_content(valid_attributes[:marketingPoints])
            expect(page).to have_content(edit_attributes[:marketingPoints])
        end
        
    end

    describe "Deletion" do
        scenario "Delete entry" do
            @temp = Member.create!(valid_attributes)
            visit members_path
            expect(page).to have_content(valid_attributes[:name])
            expect(page).to have_content(valid_attributes[:committee])
            expect(page).to have_content(valid_attributes[:position])
            expect(page).to have_content(valid_attributes[:civicPoints])
            expect(page).to have_content(valid_attributes[:outreachPoints])
            expect(page).to have_content(valid_attributes[:socialPoints])
            expect(page).to have_content(valid_attributes[:marketingPoints])
            expect(page).to have_content(valid_attributes[:totalPoints])

            visit delete_member_path(@temp)
            click_on "Delete Member"
            visit members_path
            expect(page).not_to have_content(valid_attributes[:name])
            expect(page).not_to have_content(valid_attributes[:committee])
            expect(page).not_to have_content(valid_attributes[:position])
            expect(page).not_to have_content(valid_attributes[:civicPoints])
            expect(page).not_to have_content(valid_attributes[:outreachPoints])
            expect(page).not_to have_content(valid_attributes[:socialPoints])
            expect(page).not_to have_content(valid_attributes[:marketingPoints])
            expect(page).not_to have_content(valid_attributes[:totalPoints])

        end
    end
end