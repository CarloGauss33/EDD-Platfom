require 'rails_helper'

RSpec.describe AssignmentResponseDocument, type: :model do
  describe 'Factory' do
    let(:assignment_response) { create(:assignment_response) }

    it 'has a valid factory' do
      expect(create(:assignment_response_document, assignment_response: assignment_response)).to be_valid
    end
  end

  describe 'Validations' do
    it 'validates presence of assignment_response' do
      expect(build(:assignment_response_document, assignment_response: nil)).not_to be_valid
    end

    it 'validates presence of file_data' do
      expect(build(:assignment_response_document, file_data: nil)).not_to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:assignment_response) }
  end

  describe 'Methods' do
    describe '#file_url' do
      let(:assignment_response_document) { create(:assignment_response_document) }

      it 'returns the url of the file' do
        expect(assignment_response_document.file_url).to eq(assignment_response_document.file.url)
      end
    end
  end
end
