require 'rails_helper'

RSpec.describe AssignmentResponse, type: :model do
  describe 'Factory' do
    it 'have valid Factory' do
      expect(create(:assignment_response)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:assignment) }
    it { is_expected.to belong_to(:student) }
    it { is_expected.to have_many(:assignment_question_responses) }
  end

  describe 'Validations' do
    let!(:assignment_response) { create(:assignment_response) }

    it { is_expected.to validate_presence_of(:assignment) }
    it { is_expected.to validate_presence_of(:student) }

    it 'validates uniqueness of student scoped to assignment_id' do
      expect(
        build(:assignment_response,
              student: assignment_response.student,
              assignment: assignment_response.assignment)
      ).not_to be_valid
    end
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status)}
  end

  describe 'Methods' do
    describe '#last_updated_at' do
      let(:assignment_response) { create(:assignment_response) }
      let!(:assignment_question_response) do
        create(:assignment_question_response, assignment_response: assignment_response)
      end

      it 'return last_updated_at' do
        expect(assignment_response.last_updated_at).to eq(assignment_question_response.updated_at)
      end
    end

    describe '.by_assignment_and_student' do
      let!(:assignment_response) { create(:assignment_response) }

      it 'return assignment_response' do
        expect(
          AssignmentResponse.by_assignment_and_student(
            assignment_response.assignment_id,
            assignment_response.student_id
          )
        ).to eq(assignment_response)
      end
    end
  end
end
