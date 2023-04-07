require 'rails_helper'

RSpec.describe Excuse, type: :model do

    let!(:member) { Member.create!(name: 'MyName1') }
    let!(:event) do
      Event.create!(
        name: 'Park clean up',
        date: Date.parse('2022-12-15'),
        point_type: 'Outreach',
        event_type: 'Service'
      )
    end
    

    subject do
        described_class.new(description: 'MyDescription', member_id: member.id, event_id: event.id)
    end

    # Checks if the file input is valid with or without file present
    context 'file not present' do

        it 'is valid with description' do
            expect(subject).to be_valid
        end
        it 'is valid without any information' do
            subject.description = nil
            expect(subject).to be_valid
        end
    end
    # Checks with a file attached to the form
    context 'attaching < 5 MB pdf file' do
        before do
            file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/valid_file.pdf'), 'application/pdf')
            subject.file.attach(file)
        end

        it 'is valid with given file' do
            expect(subject).to be_valid
        end
        # Check that it is valid without a description
        it 'is valid without description' do
            subject.description = nil
            expect(subject).to be_valid
        end
    end
end
