require 'rails_helper'

RSpec.describe MemberEvent, type: :model do
    # Creates member
    let(:member) {
        Member.create!(
            name: "MyName"
        )
    }
    # Creates event
    let(:event) {
        Event.create!(
            name: "Park clean up",
            date: Date.parse("2022-12-15"),
            point_type: "Outreach",
            event_type: "Service"
        )
    }
    # States valid attributes
    let(:valid_attributes) {
        {
            event_id: event.id,
            member_id: member.id
        }
    }

    subject do
        described_class.new(valid_attributes)
    end
    # Checks if valid with valid inputs
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end
    # Checks if invalid without event
    it "is not valid without event" do
        subject.event_id = nil
        expect(subject).not_to be_valid
    end
    # Checks if invalid without member name
    it "is not valid without member" do
        subject.member_id = nil
        expect(subject).not_to be_valid
    end
    # Checks if invalid without valid event (Event does not exits)
    it "is not valid missing event (id does not correspond to event)" do
        subject.event_id = -1
        expect(subject).not_to be_valid
    end
    # Checks if valid with missing member (Member does not exist)
    it "is not valid missing member (id does not correspond to event)" do
        subject.member_id = -1
        expect(subject).not_to be_valid
    end
end
