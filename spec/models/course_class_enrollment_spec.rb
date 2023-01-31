require 'rails_helper'

RSpec.describe CourseClassEnrollment, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(create(:course_class_enrollment)).to be_valid
    end
  end

  describe 'Scopes' do
    describe '#by_course_class' do
      let(:course_class) { create(:course_class) }
      let!(:course_class_enrollment) do
        create(:course_class_enrollment, course_class: course_class)
      end

      it 'returns the enrollment by course class' do
        expect(described_class.by_course_class(course_class))
          .to eq([course_class_enrollment])
      end
    end
  end

  describe 'Methods' do
    describe '#search_by_user' do
      let!(:course_class) { create(:course_class) }
      let!(:user) { create(:user) }

      context 'when the user is a valid enrollment' do
        let!(:course_class_enrollment) do
          create(
            :course_class_enrollment,
            course_class: course_class,
            email: user.email
          )
        end

        it 'returns the enrollment' do
          expect(described_class.search_by_user(user)).to eq([course_class_enrollment])
        end
      end

      context 'when the user is not a valid enrollment' do
        it 'returns nil' do
          expect(described_class.search_by_user(user)).to eq([])
        end
      end
    end

    describe '.user' do
      let!(:user) { create(:user) }

      context 'when the user is not found' do
        let(:course_class_enrollment) do
          create(:course_class_enrollment, email: '')
        end

        it 'returns nil' do
          expect(course_class_enrollment.user).to eq(nil)
        end
      end

      context 'when the user is found' do
        let(:course_class_enrollment) do
          create(:course_class_enrollment, email: user.email)
        end

        it 'returns the user' do
          expect(course_class_enrollment.user).to eq(user)
        end
      end
    end
  end
end
