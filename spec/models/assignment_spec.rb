require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'Factory' do
    let(:course) { create(:course) }

    it 'has a valid factory' do
      expect(create(:assignment, course: course)).to be_valid
    end
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status) }
  end

  describe 'Callbacks' do
    describe 'before_save' do
      let(:assignment) do
        build(:assignment, status: :active, start_date: nil, end_date: nil)
      end

      it 'sets start_date to current datetime if status is active' do
        assignment.update(status: :active)
        expect(assignment.start_date).to be_present
      end

      it 'sets end_date to current datetime if status is inactive' do
        assignment.update(status: :completed)
        expect(assignment.end_date).to be_present
      end
    end

    describe 'after_create_commit' do
      let!(:student) { create(:student) }
      let(:course) { student.course }

      it 'creates assignment response for each student' do
        assignment = create(:assignment, course: course)
        expect(assignment.assignment_responses.count).to eq(course.students.count)
      end
    end
  end
end
