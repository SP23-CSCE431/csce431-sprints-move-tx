require 'rails_helper'

RSpec.describe Event, type: :model do

    let(:valid_general) {
        {
            name: 'The Event',
            date: Date.parse('2022-01-01')
        }
    }

    let(:valid_meeting) {
        {
            event_type: 'Meeting',
            phrase: "what's up"
        }
    }

    let(:valid_service) {
        {
            point_type: 'Outreach',
            event_type: 'Service'
        }
    }

    subject do
        described_class.new(valid_service)
    end
    
    # resets attributes before test to ensure they are not changed 
    before do 
        subject.name = valid_general[:name]
        subject.date = valid_general[:date]
    end

    # when all inputs are entered it should be valid
    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end

    it 'is not valid without date' do
        subject.date = nil
        expect(subject).not_to be_valid
    end
    
    it 'is not valid without name' do
        subject.name = nil
        expect(subject).not_to be_valid
    end
    
    it 'is not valid without event_type' do
        subject.event_type = nil
        expect(subject).not_to be_valid
    end

    # if there is a meeting there needs to be a phrase 
    context 'when event_type is Meeting' do 
        before do
            subject.event_type = valid_meeting[:event_type]
            subject.phrase = valid_meeting[:phrase]
        end

        it 'is valid when there is a phrase' do
            expect(subject).to be_valid
        end

        it 'is not valid when there is not phrase' do
            subject.phrase = nil
            expect(subject).not_to be_valid
        end

    end

    # if there is a service there needs to be a point type
    context 'when event_type is Service' do
        before do
            subject.event_type = valid_service[:event_type]
            subject.point_type = valid_service[:point_type]
        end
        
        it 'is valid when there is a point_type' do
            expect(subject).to be_valid
        end
        it 'is not valid when there is not a point_type' do
            subject.point_type = nil
            expect(subject).not_to be_valid
        end
    end
    # if service needs to be point_type

    # right now it is set up to where you can enter point_type with meeting as the event type but it is changed
    # before it is entered into the database. The same goes for phrase and Service
end