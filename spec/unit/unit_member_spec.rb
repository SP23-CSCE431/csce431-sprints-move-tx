require 'rails_helper'

RSpec.describe Member, type: :model do
    let(:valid_attributes) {
        {
            name: "MyName1",
            committee: "MyCommittee1",
            position: "MyPosition1",
            civicPoints: 10010,
            outreachPoints: 10011,
            socialPoints: 10012,
            marketingPoints: 10013,
            totalPoints: 10014
        }
    }

    subject do
      described_class.new(valid_attributes)
    end
  
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end
  
    it 'is valid without a committee' do
      subject.committee = nil
      expect(subject).to be_valid
    end
  
    it 'is valid without a position' do
      subject.position = nil
      expect(subject).to be_valid
    end
  
    it 'is valid without civic points' do
      subject.civicPoints = nil
      expect(subject).to be_valid
    end
    it 'is valid without outreach points' do
      subject.outreachPoints = nil
      expect(subject).to be_valid
    end
    it 'is valid without social points' do
      subject.socialPoints = nil
      expect(subject).to be_valid
    end
    it 'is valid without marketing poitns' do
      subject.marketingPoints = nil
      expect(subject).to be_valid
    end
  
    it 'is valid without total points' do
      subject.totalPoints = nil
      expect(subject).to be_valid
    end
  end