require 'rails_helper'
require 'support/test_user'

# event creation feature test cases
RSpec.describe 'Event integration', type: :feature do

    # need to run the oauth before each test 
    include_context 'test user'

    let(:valid_meeting) {
        {name: 'Jan Meeting',
        date: Date.parse('2022-01-01'),
        event_type: 'Meeting',
        phrase: "what's up"}
    }

    let(:valid_service) {
        {name: 'Park clean up',
        date: Date.parse('2022-12-15'),
        point_type: 'Outreach',
        event_type: 'Service'}
    }

    let(:valid_non_event) {
        {name: 'Personal Event',
        date: Date.parse('2023-03-05'),
        point_type: 'Marketing',
        event_type: 'Personal/Non-Event'}
    }

    let(:edit_meeting) {
        {name: 'Feb Meeting',
        date: Date.parse('2022-02-02'),
        event_type: 'Meeting',
        phrase: "what's down"}
    }

    let(:edit_service) {
        {name: 'Public Speech',
        date: Date.parse('2022-11-10'),
        point_type: 'Outreach',
        event_type: 'Marketing'}
    }

    let(:edit_non_event) {
        {name: 'Personal Community Outreach',
        date: Date.parse('2023-03-07'),
        point_type: 'Outreach',
        event_type: 'Personal/Non-Event'}
    }

    let(:invalid_general) {
        {name: nil,
        date: nil}
    }
    
    let(:invalid_meeting) {
        {name: 'Jan Meeting',
        date: Date.parse('2022-12-15'),
        event_type: 'Meeting',
        phrase: nil}
    }

    let(:invalid_service) {
        {name: 'Park clean up',
        date: Date.parse('2022-12-15'),
        point_type: '',
        event_type: 'Service'}
    }

    let(:invalid_non_event) {
        {name: 'Personal Event',
        date: Date.parse('2023-03-05'),
        point_type: '',
        event_type: 'Personal/Non-Event'}
    }

    describe 'Creation' do
        scenario 'create meeting with valid inputs' do
            visit new_event_path
            fill_in 'event[name]', with: valid_meeting[:name]
            fill_in 'event[date]', with: valid_meeting[:date]
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[phrase]', with: valid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content('Event was successfully created')
        end

        scenario 'create service with valid inputs' do
            visit new_event_path
            fill_in 'event[name]', with: valid_service[:name]
            fill_in 'event[date]', with: valid_service[:date]
            select valid_service[:event_type], from: 'event[event_type]'
            select valid_service[:point_type], from: 'event[point_type]'
            click_on 'Create Event'
            expect(page).to have_content('Event was successfully created')
        end

        scenario 'create non-event with valid inputs' do
            visit new_event_path
            fill_in 'event[name]', with: valid_non_event[:name]
            fill_in 'event[date]', with: valid_non_event[:date]
            select valid_non_event[:event_type], from: 'event[event_type]'
            select valid_non_event[:point_type], from: 'event[point_type]'
            click_on 'Create Event'
            expect(page).to have_content('Event was successfully created')
        end

        # invalid scenarios
        scenario 'create with invalid name' do
            visit new_event_path
            fill_in 'event[name]', with: invalid_general[:name]
            fill_in 'event[date]', with: valid_meeting[:date]
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[phrase]', with: valid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Name can't be blank")
        end

        scenario 'create with invalid date' do
            visit new_event_path
            fill_in 'event[name]', with: invalid_meeting[:name]
            fill_in 'event[date]', with: invalid_general[:date]
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[phrase]', with: valid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Date can't be blank")
        end

        scenario 'create meeting without phrase' do
            visit new_event_path
            fill_in 'event[name]', with: invalid_meeting[:name]
            fill_in 'event[date]', with: invalid_general[:date]
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[phrase]', with: invalid_meeting[:phrase]
            click_on 'Create Event'
            expect(page).to have_content("Phrase can't be blank when there is a meeting")
        end

        scenario 'create service without point type' do
            visit new_event_path
            fill_in 'event[name]', with: valid_service[:name]
            fill_in 'event[date]', with: valid_service[:date]
            select valid_service[:event_type], from: 'event[event_type]'
            select invalid_service[:point_type], from: 'event[point_type]'
            click_on 'Create Event'
            expect(page).to have_content("Point type point type can't be blank when there is a service")
        end

        scenario 'create non-event without point type' do
            visit new_event_path
            fill_in 'event[name]', with: invalid_non_event[:name]
            fill_in 'event[date]', with: invalid_non_event[:date]
            select invalid_non_event[:event_type], from: 'event[event_type]'
            select invalid_non_event[:point_type], from: 'event[point_type]'
            click_on 'Create Event'
            expect(page).to have_content("Point type point type can't be blank when there is a non-event")
        end
    end

    describe 'Editing' do

        # valid scenarios
        scenario 'update service with valid inputs' do
            @temp = Event.create!(valid_service)
            visit edit_event_path(@temp)
            fill_in 'event[name]', with: edit_service[:name]
            fill_in 'event[date]', with: edit_service[:date]
            select edit_service[:point_type], from: 'event[point_type]'
            select valid_service[:event_type], from: 'event[event_type]'
            click_on 'Update Event'
            expect(page).to have_content('Event was successfully updated')
        end

        scenario 'update non-event with valid inputs' do
            @temp = Event.create!(valid_non_event)
            visit edit_event_path(@temp)
            fill_in 'event[name]', with: edit_non_event[:name]
            fill_in 'event[date]', with: edit_non_event[:date]
            select edit_non_event[:point_type], from: 'event[point_type]'
            select edit_non_event[:event_type], from: 'event[event_type]'
            click_on 'Update Event'
            expect(page).to have_content('Event was successfully updated')
        end

        scenario 'update meeting with valid inputs' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            fill_in 'event[name]', with: edit_meeting[:name]
            fill_in 'event[date]', with: edit_meeting[:date]
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[phrase]', with: edit_meeting[:phrase]
            click_on 'Update Event'
            expect(page).to have_content('Event was successfully updated')
        end

        #invalid scenarios
        scenario 'update with invalid name' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[name]', with: invalid_general[:name]
            click_on 'Update Event'
            expect(page).to have_content("Name can't be blank")
        end

        scenario 'update with invalid date' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[date]', with: invalid_general[:date]
            click_on 'Update Event'
            expect(page).to have_content("Date can't be blank")
        end

        scenario 'update with meeting without phrase' do
            @temp = Event.create!(valid_meeting)
            visit edit_event_path(@temp)
            select valid_meeting[:event_type], from: 'event[event_type]'
            fill_in 'event[phrase]', with: invalid_meeting[:phrase]
            click_on 'Update Event'
            expect(page).to have_content("Phrase can't be blank when there is a meeting")
        end

        scenario 'update with service without point type' do
            @temp = Event.create!(valid_service)
            visit edit_event_path(@temp)
            select invalid_service[:point_type], from: 'event[point_type]'
            select valid_service[:event_type], from: 'event[event_type]'
            click_on 'Update Event'
            expect(page).to have_content("Point type point type can't be blank when there is a service")
        end

        scenario 'update non-event without point type' do
            @temp = Event.create!(valid_non_event)
            visit edit_event_path(@temp)
            select invalid_non_event[:point_type], from: 'event[point_type]'
            select valid_non_event[:event_type], from: 'event[event_type]'
            click_on 'Update Event'
            expect(page).to have_content("Point type point type can't be blank when there is a non-event")
        end
    end

    describe 'Deletion' do

        scenario 'access deletion page' do
            @temp = Event.create!(valid_meeting)
            visit event_url(@temp)
            click_on 'Delete this event'
            expect(page).to have_content('Are you sure you want to permanently delete this event?')
        end

        scenario 'delete entry' do
            @temp = Event.create!(valid_meeting)
            visit delete_event_path(@temp)
            click_on 'Delete event'
            expect(page).to have_content('Event was successfully destroyed')
        end
    end
    
    # As an admin, I would like to be able to filter events/services/nonevents so that I can efficiently navigate between them 
    describe 'Event Filtering' do
        # sunny day case
        scenario 'correctly filtering event' do
            @temp = Event.create!(valid_meeting)
            @temp2 = Event.create!(valid_service)
            select 'January', from: 'date[month]'
            select '2022', from: 'date[year]'
            expect(page).to have_content('Jan Meeting')
        end
        
        #rainy day case: selecting only year option or only month option
        scenario 'incorrectly filtering event' do
            @temp = Event.create!(valid_meeting)
            @temp2 = Event.create!(valid_service)
            select 'January', from: 'date[month]'
            select '2022', from: 'date[year]'
            expect(page).to have_content('Jan Meeting')
        end
    end
end