require 'rails_helper'

RSpec.describe Excuse, type: :model do
    
    subject do
        described_class.new(description: "MyDescription")
    end

    context "file not present" do

        it 'is valid with description' do
            expect(subject).to be_valid
        end
        it 'is valid without any information' do
            subject.description = nil
            expect(subject).to be_valid
        end
    end

    context "attaching < 5 MB pdf file" do
        before do
            file = Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/valid_file.pdf"), "application/pdf")
            subject.file.attach(file)
        end

        it "is valid with given file" do
            expect(subject).to be_valid
        end

        it "is valid without description" do
            subject.description = nil
            expect(subject).to be_valid
        end
    end
end