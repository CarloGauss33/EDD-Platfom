require 'rails_helper'

RSpec.describe AssignmentResponse, type: :model do
  describe 'Factory' do
    let(:assignment) { create(:assignment) }
    let(:student) { create(:student) }

    it 'has a valid factory' do
      expect(create(:assignment_response, assignment: assignment, student: student)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:assignment) }
    it { is_expected.to belong_to(:student) }
    it { is_expected.to have_many(:assignment_response_documents) }
  end

  describe 'Validations' do
    it 'validates presence of assignment' do
      expect(build(:assignment_response, assignment: nil)).not_to be_valid
    end

    it 'validates presence of student' do
      expect(build(:assignment_response, student: nil)).not_to be_valid
    end

    it 'validates uniqueness of student scoped to assignment_id' do
      assignment = create(:assignment)
      student = create(:student)
      create(:assignment_response, assignment: assignment, student: student)
      expect(build(:assignment_response, assignment: assignment, student: student)).not_to be_valid
    end
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status) }
  end
end
