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
        member_id: member.id}
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
            # select valid_attributes[:member_id], from: "member_event[member_id]"
            click_on 'Create Member event'
            expect(page).to have_content('Member event was successfully created')
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
            click_on 'Update Member event'
            expect(page).to have_content('Member event was successfully updated')
        end
    end

    describe 'Deletion' do
        scenario 'delete entry' do
            @temp = MemberEvent.create!(valid_attributes)
            visit member_event_path(@temp)
            click_on 'Destroy this member event'
            expect(page).to have_content('Member event was successfully destroyed')
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
            visit edit_member_event_path(@member_social_event)
            check "member_event[approved_status]"
            click_on "Update Member event"
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
            visit edit_member_event_path(@member_social_event)
            check "member_event[approved_status]"
            click_on "Update Member event"
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
                point_type: 'Chapter Development'
            )
            @member_social_event = MemberEvent.create!(event_id: @social_event.id, member_id: @member1.id, approve_by:"[\"wayland\"]")
            visit edit_member_event_path(@member_social_event)
            check "member_event[approved_status]"
            click_on "Update Member event"
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
            visit edit_member_event_path(@member_social_event)
            check "member_event[approved_status]"
            click_on "Update Member event"
            visit member_path(@member1)
            expect(page).to have_content("Marketing Points 10014")
            expect(page).to have_content("Total Points 40047")
        end
    end

end