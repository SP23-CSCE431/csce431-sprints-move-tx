require 'rails_helper'

RSpec.describe Committee, type: :model do
    let(:valid_attributes) {
        {
            name: 'MyName1',
            member_id: 12345
        }
    }

    subject do
        described_class.new(valid_attributes)
    end
    # Checks if the input is valid with valid inputs
    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end
    # Checks if the input is valid with empty inputs
    it 'is not valid without name' do
        subject.name = nil;
        expect(subject).not_to be_valid
    end
    # Checks if the input is valid without leader member ID.
    it 'is valid without leader member id' do
        expect(subject).to be_valid
    end
end
