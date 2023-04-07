require 'rails_helper'

RSpec.describe Member, type: :model do
    # Test Inputs
    let!(:committee1) {
      Committee.create!(
        name: 'MyCommittee1'
      )
  }
    let(:valid_attributes) {
        {
            name: 'MyName1',
            committee_id: committee1.id,
            position: 'MyPosition1',
            civicPoints: 10010,
            outreachPoints: 10011,
            socialPoints: 10012,
            marketingPoints: 10013,
            totalPoints: 40046
        }
    }
    let(:invalid_attributes) {
        {
            name: '!nval!d',
            position: '!nval!d'
        }
    }

    subject do
        described_class.new(valid_attributes)
    end
    # It is valid with valid attributes
    it 'is valid with valid attributes' do
    expect(subject).to be_valid
end

    # Checks that it is not valid without a name
    it 'is not valid without a name' do
        subject.name = nil
        expect(subject).not_to be_valid
    end
    # Checks that it is not valid with an invalid name
    it 'is not valid with invalid name' do
        subject.name = invalid_attributes[:name]
        expect(subject).not_to be_valid
    end

    # Checks that it is valid without a committee
    it 'is valid without a committee' do
        subject.committee = nil
        expect(subject).to be_valid
    end

    # Checks that it is valid without a position
    it 'is valid without a position' do
        subject.position = nil
        expect(subject).to be_valid
    end
    # Checks that it is not valid with an invalid name
    it 'is not valid with invalid position' do
        subject.position = invalid_attributes[:position]
        expect(subject).not_to be_valid
    end

    # Checks that it is valid without a civic points
    it 'is valid without civic points' do
        subject.civicPoints = nil
        expect(subject).to be_valid
    end

    # Checks that it is valid without a outreach points
    it 'is valid without outreach points' do
        subject.outreachPoints = nil
        expect(subject).to be_valid
    end

    # Checks that it is valid without a social points
    it 'is valid without social points' do
        subject.socialPoints = nil
        expect(subject).to be_valid
    end

    # Checks that it is valid without a marketing points
    it 'is valid without marketing poitns' do
        subject.marketingPoints = nil
        expect(subject).to be_valid
    end

    # Checks that it is valid without a total points
    it 'is valid without total points' do
        subject.totalPoints = nil
        expect(subject).to be_valid
    end
end
