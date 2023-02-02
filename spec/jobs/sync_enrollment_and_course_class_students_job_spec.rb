require 'rails_helper'

RSpec.describe SyncEnrollmentAndCourseClassStudentsJob, type: :job do
  describe '#perform' do
    let!(:user) { create(:user) }
    let!(:course_class) { create(:course_class) }
    let!(:course_class_enrollment) do
      create(:course_class_enrollment, course_class: course_class, email: user.email)
    end

    it 'creates a new course class student enrollment' do
      expect { described_class.perform_now(course_class.id) }
        .to change { Student.count }.by(1)
    end
  end
end
