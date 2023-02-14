# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec. describe Member, type: :model do
  subject do
    described_class.new(name: 'Pauline Wade',
                        committee: 'Teacher',
                        position: 'Professor',
                        civicPoints: 1,
                        outreachPoints: 2,
                        socialPoints: 3,
                        marketingPoints: 4,
                        totalPoints: 10)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a committee' do
    subject.committee = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a position' do
    subject.position = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without civic points' do
    subject.civicPoints = nil
    expect(subject).not_to be_valid
  end
  it 'is not valid without outreach points' do
    subject.outreachPoints = nil
    expect(subject).not_to be_valid
  end
  it 'is not valid without social points' do
    subject.socialPoints = nil
    expect(subject).not_to be_valid
  end
  it 'is not valid without marketing poitns' do
    subject.marketingPoints = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without total points' do
    subject.totalPoints = nil
    expect(subject).not_to be_valid
  end
end
