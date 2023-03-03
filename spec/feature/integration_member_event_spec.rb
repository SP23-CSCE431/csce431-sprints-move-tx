require 'rails_helper'
require "support/test_user"

RSpec.describe "Member_Event integration", type: :feature do
    # need to run the oauth before each test 
    include_context 'test user'

    let!(:member) {
        Member.create!(
        name: "MyName1"
        )
    }
    let!(:event) {
        Event.create!(
            name: "Park clean up",
            date: Date.parse("2022-12-15"),
            point_type: "Outreach",
            event_type: "Service"
        )
    }

    let!(:member2) {
        Member.create!(
          name: "MyName2"
        )
    }

    let!(:member3) {
        Member.create!(
            name: "myName3"
        )
    }
    let!(:event2) {
        Event.create!(
            name: "Jan Meeting",
            date: Date.parse("2022-01-01"),
            event_type: "Meeting",
            phrase: "what's up"
        )
    }


    let!(:valid_attributes) {
        {event_id: event.id,
        member_id: member.id}
    }

    let!(:edit_attributes) {
        {event_id: event2.id,
        member_id: member2.id}
    }

    let!(:valid_meeting) {
        {
        event_id: event2.id,
        member_id: member3.id
        }
    }

    

    let(:invalid_attributes) {
        skip("Add a hash of attributes invalid for your model")
    }

    describe "Creation" do
        scenario "create Service event with valid inputs" do
            visit new_member_event_path(version: 1)
            select event.name, from: "member_event[event_id]"
            # select valid_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Create Member event'
            expect(page).to have_content("Member event was successfully created")
        end

        scenario "create Meeting Event with correct phrase" do
            visit new_member_event_path(version: 2)
            select event.name, from: "member_event[event_id]"
            fill_in "member_event[phrase]",  with: event2[:phrase]
            click_on 'Sign into meeting'
            expect(page).to have_content("You successfully signed into meeting")
        end

        scenario "create Meeting Event with wrong phrase" do
            visit new_member_event_path(version: 2)
            select event.name, from: "member_event[event_id]"
            fill_in "member_event[phrase]",  with: "1234"
            click_on 'Sign into meeting'
            expect(page).to have_content("Entered wrong password try again")
        end
    end

    describe "Editing" do
        scenario 'update with valid inputs' do
            @temp = MemberEvent.create!(edit_attributes)
            visit edit_member_event_path(@temp)
            select event.name, from: "member_event[event_id]"
            # select edit_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Update Member event'
            expect(page).to have_content("Member event was successfully updated")
        end
    end

    describe "Deletion" do
        scenario 'delete entry' do
            @temp = MemberEvent.create!(valid_attributes)
            visit member_event_path(@temp)
            click_on 'Destroy this member event'
            expect(page).to have_content("Member event was successfully destroyed")
        end
    end

    # # testing admin view of member_event based on being asked to review
    # describe "view" do
    #     scenario "create with valid inputs with specific officer name" do
    #         visit new_member_event_path
    #         select valid_attributes[:event_id], from: "member_event[event_id]"
    #         select valid_attributes[:member_id], from: "member_event[member_id]"
    #         select
    #         click_on 'Create Member event'
    #         expect(page).to have_content("Member event successfully created")
    #     end

end