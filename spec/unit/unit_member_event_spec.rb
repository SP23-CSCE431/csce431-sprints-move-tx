require 'rails_helper'

RSpec.describe MemberEvent, type: :model do

    let(:member) {
        Member.create!(
            name: "MyName"
        )
    }

    let(:event) {
        Event.create!(
            name: "Park clean up",
            date: Date.parse("2022-12-15"),
            point_type: "Outreach",
            event_type: "Service"
        )
    }

    let(:valid_attributes) {
        {
            event_id: event.id,
            member_id: member.id
        }
    }

    subject do
        described_class.new(valid_attributes)
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without event" do
        subject.event_id = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without member" do
        subject.member_id = nil
        expect(subject).not_to be_valid
    end

    it "is not valid missing event (id does not correspond to event)" do
        subject.event_id = -1
        expect(subject).not_to be_valid
    end

    it "is not valid missing member (id does not correspond to event)" do
        subject.member_id = -1
        expect(subject).not_to be_valid
    end
end