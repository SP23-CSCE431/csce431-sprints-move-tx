require 'rails_helper'
require 'support/test_user'

RSpec.describe 'Member_Event integration', type: :feature do
    # need to run the oauth before each test 
    include_context 'test user'

    let!(:member) {
        Member.create!(
        name: 'MyName1'
        )
    }
    let!(:event) {
        Event.create!(
            name: 'Park clean up',
            date: Date.parse('2022-12-15'),
            point_type: 'Outreach',
            event_type: 'Service'
        )
    }

    let!(:event3) {
        Event.create!(
            name: 'Personal Non Event Outreach',
            date: Date.parse('2022-12-15'),
            point_type: 'Outreach',
            event_type: 'Personal/Non-Event'
        )
    }

    let!(:member2) {
        Member.create!(
          name: 'MyName2'
        )
    }

    let!(:member3) {
        Member.create!(
            name: 'myName3'
        )
    }
    let!(:event2) {
        Event.create!(
            name: 'Jan Meeting',
            date: Date.parse('2022-01-01'),
            event_type: 'Meeting',
            phrase: "what's up"
        )
    }


    let!(:valid_attributes) {
        {event_id: event.id,
        member_id: member.id,
        approve_by: 'wayland',
        approved_status: 'true'}
    }

    let!(:valid_attributes_pending) {
        {event_id: event.id,
        member_id: member.id,
        approve_by: 'wayland',
        approved_status: 'false'}
    }

    let!(:edit_attributes) {
        {event_id: event.id,
        member_id: member.id}
    }

    let!(:valid_meeting) {
        {
        event_id: event2.id,
        member_id: member3.id
        }
    }


    let!(:valid_member_attributes) {
        {
            name: 'MyName1',
            # committee_id: committee1.id,
            position: 'MyPosition1',
            civicPoints: 10010,
            outreachPoints: 10011,
            socialPoints: 10012,
            marketingPoints: 10013,
            totalPoints: 40046,
            status: true
        }
    }


    

    let(:invalid_attributes) {
        skip('Add a hash of attributes invalid for your model')
    }

    describe 'Creation' do
        scenario 'create Service event with valid inputs' do
            visit new_member_event_path(version: 1)
            select event.name, from: 'member_event[event_id]'
            check('member_event[officer_ids][]')
            # select valid_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Submit service'
            expect(page).to have_content('Service was successfully submitted')
        end

        # personal/Non-Event sunny day scenario
        scenario 'create individual service with valid inputs' do
            visit new_member_event_path(version: 3)
            select event3.name, from: 'member_event[event_id]'
            check('member_event[officer_ids][]')
            fill_in 'member_event[description]', with: "I did this and whatever"
            # select valid_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Submit Personal/Non-Event'
            expect(page).to have_content('Personal/Non-Event was successfully submitted')
        end

        # Meeting creation sunny day scenario 
        scenario 'create Meeting Event with correct phrase' do
            visit new_member_event_path(version: 2)
            select event2.name, from: 'member_event[event_id]'
            fill_in 'member_event[phrase]',  with: event2[:phrase]
            click_on 'Sign into meeting'
            expect(page).to have_content('You successfully signed into meeting')
        end
        
        # Meeting creation rainy day scenario 
        scenario 'create Meeting Event with wrong phrase' do
            visit new_member_event_path(version: 2)
            select event2.name, from: 'member_event[event_id]'
            fill_in 'member_event[phrase]',  with: '1234'
            click_on 'Sign into meeting'
            expect(page).to have_content('Entered wrong password try again')
        end
    end

    describe 'Editing' do
        # Service editing sunny day scenario
        scenario 'Editing Service with valid inputs' do
            @temp = MemberEvent.create!(edit_attributes)
            visit edit_member_event_path(@temp, version: 1)
            select event.name, from: 'member_event[event_id]'
            # select edit_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Edit service'
            expect(page).to have_content('Service was successfully updated')
        end
    end

    describe 'Deletion' do
        scenario 'delete entry' do
            @temp = MemberEvent.create!(valid_attributes)
            visit delete_member_event_path(@temp)
            click_on 'Delete service'
            expect(page).to have_content('Service was successfully destroyed')
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

    # test for updating points when event is approved
    describe 'Point update on approval' do
        scenario 'Civic Point Update' do
            @member1 = Member.create!(valid_member_attributes)
            @social_event = Event.create!(
                name: 'Jan Meeting',
                date: Date.parse('2022-01-01'),
                event_type: 'Service',
                point_type: 'Civic Engagement'
            )
            @member_social_event = MemberEvent.create!(event_id: @social_event.id, member_id: @member1.id, approve_by:"[\"wayland\"]")
            visit member_event_path(@member_social_event)
            click_on "Approve"
            visit member_path(@member1)
            expect(page).to have_content("Civic Points 10011")
            expect(page).to have_content("Total Points 40047")
        end

        scenario 'Outreach Point Update' do
            @member1 = Member.create!(valid_member_attributes)
            @social_event = Event.create!(
                name: 'Jan Meeting',
                date: Date.parse('2022-01-01'),
                event_type: 'Service',
                point_type: 'Outreach'
            )
            @member_social_event = MemberEvent.create!(event_id: @social_event.id, member_id: @member1.id, approve_by:"[\"wayland\"]")
            visit member_event_path(@member_social_event)
            click_on "Approve"
            visit member_path(@member1)
            expect(page).to have_content("Outreach Points 10012")
            expect(page).to have_content("Total Points 40047")
        end

        scenario 'Social Point Update' do
            @member1 = Member.create!(valid_member_attributes)
            @social_event = Event.create!(
                name: 'Jan Meeting',
                date: Date.parse('2022-01-01'),
                event_type: 'Service',
                point_type: 'Social'
            )
            @member_social_event = MemberEvent.create!(event_id: @social_event.id, member_id: @member1.id, approve_by:"[\"wayland\"]")
            visit member_event_path(@member_social_event)
            click_on "Approve"
            visit member_path(@member1)
            expect(page).to have_content("Social Points 10013")
            expect(page).to have_content("Total Points 40047")
        end

        scenario 'Marketing Point Update' do
            @member1 = Member.create!(valid_member_attributes)
            @social_event = Event.create!(
                name: 'Jan Meeting',
                date: Date.parse('2022-01-01'),
                event_type: 'Service',
                point_type: 'Marketing'
            )
            @member_social_event = MemberEvent.create!(event_id: @social_event.id, member_id: @member1.id, approve_by:"[\"wayland\"]")
            visit member_event_path(@member_social_event)
            click_on "Approve"
            visit member_path(@member1)
            expect(page).to have_content("Marketing Points 10014")
            expect(page).to have_content("Total Points 40047")
        end
    end

    describe 'Approval filtering' do
        # sunny day cases
        scenario 'correctly filtering event for approved services' do
            visit member_events_path
            @temp = MemberEvent.create!(valid_attributes)
            @temp1 = MemberEvent.create!(valid_attributes_pending)
            select 'Approved', from: 'service_status'
            click_on 'Search'
            expect(page).to have_content('true')
            expect(page).not_to have_content('false')
        end
        scenario 'correctly filtering event for pending services' do
            visit member_events_path
            @temp = MemberEvent.create!(valid_attributes_pending)
            @temp1 = MemberEvent.create!(valid_attributes)
            select 'Pending', from: 'service_status'
            click_on 'Search'
            expect(page).to have_content('false')
            expect(page).not_to have_content('true')
        end
    end
end