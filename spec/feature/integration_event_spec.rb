require 'rails_helper'

# event creation feature test cases
RSpec.describe 'Event integration', type: :feature do

    let(:valid_meeting) {
        {name: "Jan Meeting",
        date: Date.parse("2022-01-01"),
        event_type: "Meeting",
        phrase: "what's up"}
    }

    let(:valid_service) {
        {name: "Park clean up",
        date: Date.parse("2022-12-15"),
        point_type: "Outreach",
        event_type: "Service"}
    }

    let(:edit_meeting) {
        {name: "Feb Meeting",
        date: Date.parse("2022-02-02"),
        event_type: "Meeting",
        phrase: "what's down"}
    }

    let(:edit_service) {
        {name: "Public Speech",
        date: Date.parse("2022-11-10"),
        point_type: "Outreach",
        event_type: "Marketing"}
    }

    let(:invalid_general) {
        {name: nil,
        date: nil}
    }
    
    let(:invalid_meeting) {
        {name: "Jan Meeting",
        date: Date.parse("2022-12-15"),
        event_type: "Meeting",
        phrase: nil}
    }

    let(:invalid_service) {
        {name: "Park clean up",
        date: Date.parse("2022-12-15"),
        point_type: '',
        event_type: "Service"}
    }

    describe "Creation" do
        scenario 'create meeting with valid inputs' do
            visit new_event_path
            fill_in "event[name]", with: valid_meeting[:name]
            fill_in "event[date]", with: valid_meeting[:date]
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[phrase]", with: valid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Event was successfully created")
        end

        scenario 'create service with valid inputs' do
            visit new_event_path
            fill_in "event[name]", with: valid_service[:name]
            fill_in "event[date]", with: valid_service[:date]
            select valid_service[:event_type], from: "event[event_type]"
            select valid_service[:point_type], from: "event[point_type]"
            click_on 'Create Event'
            expect(page).to have_content("Event was successfully created")
        end

        # invalid scenarios
        scenario 'create with invalid name' do
            visit new_event_path
            fill_in "event[name]", with: invalid_general[:name]
            fill_in "event[date]", with: valid_meeting[:date]
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[phrase]", with: valid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Name cant be blank")
        end

        scenario 'create with invalid date' do
            visit new_event_path
            fill_in "event[name]", with: invalid_meeting[:name]
            fill_in "event[date]", with: invalid_general[:date]
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[phrase]", with: valid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Date can't be blank")
        end

        scenario 'create meeting without phrase' do
            visit new_event_path
            fill_in "event[name]", with: invalid_meeting[:name]
            fill_in "event[date]", with: invalid_general[:date]
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[phrase]", with: invalid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Phrase can't be blank when there is a meeting")
        end

        scenario 'create service without point type' do
            visit new_event_path
            fill_in "event[name]", with: valid_service[:name]
            fill_in "event[date]", with: valid_service[:date]
            select valid_service[:event_type], from: "event[event_type]"
            select invalid_service[:point_type], from: "event[point_type]"
            click_on 'Create Event'
            expect(page).to have_content("Point type point type can't be blank when there is a service")
        end
    end

    describe "Editing" do

        # valid scenarios
        scenario 'update service with valid inputs' do
            @temp = Event.create!(valid_service)
            visit edit_event_path(@temp)
            fill_in "event[name]", with: edit_service[:name]
            fill_in "event[date]", with: edit_service[:date]
            select edit_service[:point_type], from: "event[point_type]"
            select valid_service[:event_type], from: "event[event_type]"
            click_on 'Update Event'
            expect(page).to have_content("Event was successfully updated")
        end

        scenario 'update meeting with valid inputs' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            fill_in "event[name]", with: edit_meeting[:name]
            fill_in "event[date]", with: edit_meeting[:date]
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[phrase]", with: edit_meeting[:phrase]
            click_on 'Update Event'
            expect(page).to have_content("Event was successfully updated")
        end

        #invalid scenarios
        scenario 'update with invalid name' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[name]", with: invalid_general[:name]
            click_on 'Update Event'
            expect(page).to have_content("Name can't be blank")
        end

        scenario 'update with invalid date' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[date]", with: invalid_general[:date]
            click_on 'Update Event'
            expect(page).to have_content("Date can't be blank")
        end

        scenario 'update with meeting without phrase' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            select valid_meeting[:event_type], from: "event[event_type]"
            fill_in "event[phrase]", with: invalid_meeting[:phrase]
            click_on 'Update Event'
            expect(page).to have_content("Phrase can't be blank when there is a meeting")
        end

        scenario 'update with service without point type' do
            @temp = Event.create!(valid_service)
            visit edit_event_path(@temp)
            select invalid_service[:point_type], from: "event[point_type]"
            select valid_service[:event_type], from: "event[event_type]"
            click_on 'Update Event'
            expect(page).to have_content("Point type point type can't be blank when there is a service")
        end
    end

    describe "Deletion" do

        scenario 'access deletion page' do
            @temp = Event.create!(valid_meeting)
            visit event_url(@temp)
            click_on 'Delete this event'
            expect(page).to have_content("Are you sure you want to permanently delete this event?")
        end

        scenario 'delete entry' do
            @temp = Event.create!(valid_meeting)
            visit delete_event_path(@temp)
            click_on 'Delete event'
            expect(page).to have_content("Event was successfully destroyed")
        end
    end
end