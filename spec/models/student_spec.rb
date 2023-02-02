require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(create(:student)).to be_valid
    end
  end

  describe 'Validations' do
    let(:user) { create(:user) }
    let(:course_class) { create(:course_class) }

    before do
      create(:student, user: user, course_class: course_class)
    end

    it 'validates uniqueness of user_id scoped to course_class_id' do
      expect(build(:student, user: user, course_class: course_class)).not_to be_valid
    end
  end

  describe 'Callbacks' do
    let!(:course_class) { create(:course_class) }
    let!(:assignment) { create(:assignment, course: course_class.course) }
    let(:user) { create(:user) }

    it 'creates assignment responses after create' do
      expect do
        create(:student, user: user, course_class: course_class)
      end.to change { AssignmentResponse.count }.by(1)
    end
  end

  describe 'Scopes' do
    let(:course_class) { create(:course_class) }
    let(:user) { create(:user) }
    let!(:student) { create(:student, user: user, course_class: course_class) }

    describe '#by_user' do
      it 'returns the student by user' do
        expect(described_class.by_user(user)).to eq([student])
      end

      it 'returns nil if no student is found' do
        expect(described_class.by_user(create(:user))).to eq([])
      end
    end

    describe '#by_course' do
      it 'returns the student by course' do
        expect(described_class.by_course(course_class.course)).to eq([student])
      end
    end
  end

  describe 'Methods' do
    let(:course_class) { create(:course_class) }
    let(:user) { create(:user) }
    let!(:student) { create(:student, user: user, course_class: course_class) }

    describe '#by_course_and_user' do
      it 'returns the student by course and user' do
        expect(described_class.by_course_and_user(course_class.course, user)).to eq(student)
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course_class) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status) }
  end
end
