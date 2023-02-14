require 'rails_helper'

RSpec.describe Excuse, type: :model do
  describe "file attachment validations" do
    let(:excuse) { build(:excuse) }

    context "file size is >= 5MB" do
      before do
        file = Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/large_file.pdf"), "application/pdf")
        excuse.file.attach(file)
      end
      it "is invalid" do
        expect(excuse).to be_invalid
        expect(excuse.errors[:file]).to include("File size is too large (Size > 5MB)")
      end
    end

    context "file is not a PDF" do
      before do
        file = Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/non_pdf.txt"), "text/plain")
        excuse.file.attach(file)
      end
      it "is invalid" do
        expect(excuse).to be_invalid
        expect(excuse.errors[:file]).to include("File must be a PDF")
      end
    end
  end
end
