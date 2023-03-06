require 'rails_helper'
require 'support/test_user'

RSpec.describe 'Members integration', type: :feature do
    # need to run the oauth before each test 
    include_context 'test user'

    let(:valid_attributes) {
        {
            name: 'MyName1',
            committee: 'MyCommittee1',
            position: 'MyPosition1',
            civicPoints: 10010,
            outreachPoints: 10011,
            socialPoints: 10012,
            marketingPoints: 10013,
            totalPoints: 40046
        }
    }

    let(:edit_attributes) {
        {
            name: 'MyName2',
            committee: 'MyCommittee2',
            position: 'MyPosition2',
            civicPoints: 10090,
            outreachPoints: 10091,
            socialPoints: 10092,
            marketingPoints: 10093,
            totalPoints: 40366
        }
    }

    let(:invalid_attributes) {
        {
            name: nil
        }
    }

    describe 'Creation' do
        scenario 'create with valid inputs' do
            visit new_member_path
            
            fill_in 'member[name]',             with: valid_attributes[:name]
            fill_in 'member[committee]',        with: valid_attributes[:committee]
            fill_in 'member[position]',         with: valid_attributes[:position]
            fill_in 'member[civicPoints]',      with: valid_attributes[:civicPoints]
            fill_in 'member[outreachPoints]',   with: valid_attributes[:outreachPoints]
            fill_in 'member[socialPoints]',     with: valid_attributes[:socialPoints]
            fill_in 'member[marketingPoints]',  with: valid_attributes[:marketingPoints]
            #fill_in "member[totalPoints]",      with: valid_attributes[:totalPoints]
            click_on 'Create Member'
            
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
            
            fill_in 'member[committee]',        with: valid_attributes[:committee]
            fill_in 'member[position]',         with: valid_attributes[:position]
            fill_in 'member[civicPoints]',      with: valid_attributes[:civicPoints]
            fill_in 'member[outreachPoints]',   with: valid_attributes[:outreachPoints]
            fill_in 'member[socialPoints]',     with: valid_attributes[:socialPoints]
            fill_in 'member[marketingPoints]',  with: valid_attributes[:marketingPoints]
            #fill_in "member[totalPoints]",      with: valid_attributes[:totalPoints]
            click_on 'Create Member'
            
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

    describe 'Editing' do
        scenario 'update with valid inputs' do
            @temp = Member.create!(valid_attributes)
            visit member_url(@temp)
            expect(page).to have_content(valid_attributes[:name])
            expect(page).to have_content(valid_attributes[:committee])
            expect(page).to have_content(valid_attributes[:position])
            expect(page).to have_content(valid_attributes[:civicPoints])
            expect(page).to have_content(valid_attributes[:outreachPoints])
            expect(page).to have_content(valid_attributes[:socialPoints])
            expect(page).to have_content(valid_attributes[:marketingPoints])
            expect(page).to have_content(valid_attributes[:totalPoints])

            visit edit_member_path(@temp)

            fill_in 'member[name]',             with: edit_attributes[:name]
            fill_in 'member[committee]',        with: edit_attributes[:committee]
            fill_in 'member[position]',         with: edit_attributes[:position]
            fill_in 'member[civicPoints]',      with: edit_attributes[:civicPoints]
            fill_in 'member[outreachPoints]',   with: edit_attributes[:outreachPoints]
            fill_in 'member[socialPoints]',     with: edit_attributes[:socialPoints]
            fill_in 'member[marketingPoints]',  with: edit_attributes[:marketingPoints]
            #fill_in "member[totalPoints]",      with: edit_attributes[:totalPoints]

            click_on 'Update Member'
            visit member_url(@temp)
            expect(page).to have_content(edit_attributes[:name])
            expect(page).to have_content(edit_attributes[:committee])
            expect(page).to have_content(edit_attributes[:position])
            expect(page).to have_content(edit_attributes[:civicPoints])
            expect(page).to have_content(edit_attributes[:outreachPoints])
            expect(page).to have_content(edit_attributes[:socialPoints])
            expect(page).to have_content(edit_attributes[:marketingPoints])
            expect(page).to have_content(edit_attributes[:totalPoints])
        end
        
    end

    describe 'Deletion' do
        scenario 'delete entry' do
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
            click_on 'Delete Member'
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
