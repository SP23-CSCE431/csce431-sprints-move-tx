require 'rails_helper'

RSpec.describe "Member_Event integration", type: :feature do

    let(:member) {
        Member.create!(
        name: "MyName"
        )
    }
    let(:event) {
        Event.create!(
          name: "MyName",
          date: Date.parse("01-01-2023"),
          event_type: "MyType"
        )
    }

    let(:member2) {
        Member.create!(
          name: "MyName2"
        )
    }
    let(:event2) {
        Event.create!(
          name: "MyName2",
          date: Date.parse("01-01-2023"),
          event_type: "MyType"
        )
    }

    let(:valid_attributes) {
        {event_id: event.id,
        member_id: member.id}
    }

    let(:edit_attributes) {
        {event_id: event2.id,
        member_id: member2.id}
    }

    let(:invalid_attributes) {
        skip("Add a hash of attributes invalid for your model")
    }

    describe "Creation" do
        scenario "create with valid inputs" do
            visit new_member_event_path
            select valid_attributes[:event_id], from: "member_event[event_id]"
            select valid_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Create Member event'
            expect(page).to have_content("Member event successfully created")
        end
    end

    describe "Editing" do

        scenario 'update with valid inputs' do
            @temp = Member_Event.create!(valid_attributes)
            visit edit_member_event_path(@temp)
            select edit_attributes[:event_id], from: "member_event[event_id]"
            select edit_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Update Member event'
            expect(page).to have_content("Member event was successfully updated")
        end
    end

    describe "Deletion" do
        scenario 'delete entry' do
            @temp = Member_Event.create!(valid_meeting)
            visit delete_event_path(@temp)
            click_on 'Destroy this member event'
            expect(page).to have_content("Event was successfully destroyed")
        end
    end
end