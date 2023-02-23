require 'rails_helper'

RSpec.describe Committee, type: :model do
    let(:valid_attributes) {
        {
            name: "MyName1",
            leader_member_id: 12345
        }
    }
    
    subject do
        described_class.new(valid_attributes)
    end

    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end

    it 'is valid without name' do
        subject.name = nil;
        expect(subject).to be_valid
    end

    it 'is valid without leader member id' do
        expect(subject).to be_valid
    end
end