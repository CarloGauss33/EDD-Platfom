require 'rails_helper'

RSpec.describe AssignmentQuestionResponse, type: :model do
  describe 'Factory' do
    it 'have valid Factory' do
      expect(create(:assignment_question_response)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:assignment_question) }
    it { is_expected.to belong_to(:assignment_response) }
  end

  describe 'Validations' do
    let!(:assignment_question_response) { create(:assignment_question_response) }

    it { is_expected.to validate_presence_of(:assignment_question) }
    it { is_expected.to validate_presence_of(:assignment_response) }

    it 'validates uniqueness of assignment_question scoped to assignment_response_id' do
      expect(
        build(:assignment_question_response,
              assignment_question: assignment_question_response.assignment_question,
              assignment_response: assignment_question_response.assignment_response)
      ).not_to be_valid
    end
  end

  describe 'Delegations' do
    it { is_expected.to delegate_method(:url).to(:file).with_prefix }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status) }
  end

  describe 'Methods' do
    describe '#filename' do
      let(:assignment_question_response) { create(:assignment_question_response) }

      it 'return filename' do
        expect(assignment_question_response.filename).to eq('edd.png')
      end
    end
  end
end
