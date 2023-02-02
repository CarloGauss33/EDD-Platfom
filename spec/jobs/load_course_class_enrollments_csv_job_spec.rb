require 'rails_helper'
require 'csv'

RSpec.describe LoadCourseClassEnrollmentsCsvJob, type: :job do
  describe 'perform' do
    context 'when the csv is valid' do
      let(:course_class) { create(:course_class) }
      let(:csv) do
        csv_file = Tempfile.new('enrollments.csv')
        csv_file.write(
          CSV.generate do |csv|
            csv << %w[email rut university_id enrollment_id full_name]
            3.times do
              csv << [
                Faker::Internet.email,
                Faker::IDNumber.chilean_id,
                '123456789',
                '123456789',
                'MyString'
              ]
            end
          end
        )
        csv_file.rewind
        csv_file
      end

      def perform
        described_class.perform_now(course_class.id, csv)
      end

      it 'creates course_class_student_enrollments' do
        expect { perform }.to change { CourseClassEnrollment.count }.by(3)
      end

      it 'updates course_class.enrollments_loaded_at' do
        perform
        expect(course_class.reload.enrollments_loaded_at).not_to be_nil
      end
    end
  end
end
