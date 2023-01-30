class CourseClassEnrollment < ApplicationRecord
  CSV_FIELDS = %w[email rut university_id enrollment_id full_name].freeze

  belongs_to :course_class

  scope :by_course_class, ->(course_class) { where(course_class: course_class) }

  def self.search_by_user(user)
    where(
      "email = ? OR rut = ? OR university_id = ? OR enrollment_id = ? OR full_name = ?",
      user.email,
      user.rut,
      user.university_id,
      user.canvas_user_id,
      user.full_name
    )
  end
end

# == Schema Information
#
# Table name: course_class_enrollments
#
#  id              :bigint(8)        not null, primary key
#  course_class_id :bigint(8)        not null
#  email           :string
#  rut             :string
#  university_id   :string
#  enrollment_id   :string
#  full_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_course_class_enrollments_on_course_class_id  (course_class_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_class_id => course_classes.id)
#
