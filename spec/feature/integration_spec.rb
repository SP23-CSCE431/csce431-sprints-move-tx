require 'rails_helper'

# event creation feature test cases
RSpec.describe 'Creating an Event', type: :feature do

    # invalid scenarios
    scenario 'invalid name' do 
        visit new_event_path
        fill_in "event[phrase]", with: 'whats up'
        fill_in "event[date]", with: "2022-12-15"
        select "Meeting", from: "event[event_type]"
        click_on 'Create Event'
        expect(page).to have_content("Name can't be blank")
    end

    scenario 'invalid date' do
        visit new_event_path
        fill_in "event[phrase]", with: 'whats up'
        fill_in "event[name]", with: "jan meeting"
        select "Meeting", from: "event[event_type]"
        click_on 'Create Event'
        expect(page).to have_content("Date can't be blank")
    end

    scenario 'Meeting without phrase' do
        visit new_event_path
        fill_in "event[name]", with: "jan meeting"
        fill_in "event[date]", with: "2022-12-15"
        select "Meeting", from: "event[event_type]"
        click_on 'Create Event'
        expect(page).to have_content("Phrase can't be blank when there is a meeting")
    end

    scenario 'Service without point type' do
        visit new_event_path
        fill_in "event[name]", with: "Park clean up"
        fill_in "event[date]", with: "2022-12-15"
        select "Service", from: "event[event_type]"
        click_on 'Create Event'
        expect(page).to have_content("Point type point type can't be blank when there is a service")
    end

    # valid scenarios
    scenario 'valid Service Submission' do 
        visit new_event_path
        fill_in "event[name]", with: "Park clean up"
        fill_in "event[date]", with: "2022-12-15"
        select "Service", from: "event[event_type]"
        select "Outreach", from: "event[point_type]"
        click_on 'Create Event'
        expect(page).to have_content("Event was successfully created")
    end

    scenario 'valid Meeting Submision' do
        visit new_event_path
        fill_in "event[name]", with: "feb meeting"
        fill_in "event[date]", with: "2022-12-15"
        select "Meeting", from: "event[event_type]"
        fill_in "event[phrase]", with: "merry"
        click_on 'Create Event'
        expect(page).to have_content("Event was successfully created")
    end
end

# event update feature test cases
RSpec.describe 'Creating an Event', type: :feature do

    # creates event to be updated before each test 
    before do
        visit new_event_path
        fill_in "event[name]", with: "Park clean up"
        fill_in "event[date]", with: "2022-12-15"
        select "Service", from: "event[event_type]"
        select "Outreach", from: "event[point_type]"
        click_on 'Create Event'
    end

    #invalid scenarios
    scenario 'invalid name' do
        click_on 'Edit this event'
        fill_in "event[name]", with: ''
        click_on 'Update Event'
        expect(page).to have_content("Name can't be blank")
    end

    scenario 'invalid date' do
        click_on 'Edit this event'
        fill_in "event[date]", with: ""
        click_on 'Update Event'
        expect(page).to have_content("Date can't be blank")
    end

    scenario 'Meeting without phrase' do
        click_on 'Edit this event'
        select "Meeting", from: "event[event_type]"
        fill_in "event[phrase]", with: ""
        click_on 'Update Event'
        expect(page).to have_content("Phrase can't be blank when there is a meeting")
    end

    scenario 'Service without point type' do
        click_on 'Edit this event'
        select "Service", from: "event[event_type]"
        select "", from: "event[point_type]"
        click_on 'Update Event'
        expect(page).to have_content("Point type point type can't be blank when there is a service")
    end

    # valid scenarios
    scenario 'valid Service Update' do 
        click_on 'Edit this event'
        fill_in "event[name]", with: "public speech"
        fill_in "event[date]", with: "2022-11-10"
        select "Service", from: "event[event_type]"
        select "Marketing", from: "event[point_type]"
        click_on 'Update Event'
        expect(page).to have_content("Event was successfully updated")
    end

    scenario 'valid Meeting Submision' do
        click_on 'Edit this event'
        fill_in "event[name]", with: "feb meeting"
        fill_in "event[date]", with: "2022-12-15"
        select "Meeting", from: "event[event_type]"
        fill_in "event[phrase]", with: "merry"
        click_on 'Update Event'
        expect(page).to have_content("Event was successfully updated")
    end
end

# event delete feature test cases
RSpec.describe 'Creating an Event', type: :feature do

    #creates event to be deleted before each test 
    before do
        visit new_event_path
        fill_in "event[name]", with: "Park clean up"
        fill_in "event[date]", with: "2022-12-15"
        select "Service", from: "event[event_type]"
        select "Outreach", from: "event[point_type]"
        click_on 'Create Event'
    end

    scenario 'going to delete page event' do
        click_on 'Delete this event'
        expect(page).to have_content("Are you sure you want to permanently delete this event?")
    end

    scenario 'deleteing event' do
        click_on 'Delete this event'
        click_on 'Delete event'
        expect(page).to have_content("Event was successfully destroyed")
    end
end
