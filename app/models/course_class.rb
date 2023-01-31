class CourseClass < ApplicationRecord
  belongs_to :course

  has_many :students, dependent: :destroy
  has_many :users, through: :students

  accepts_nested_attributes_for :students, allow_destroy: true

  delegate :name, to: :course
  delegate :assignments, to: :course

  validates :section, uniqueness: { scope: :course_id }
end

# == Schema Information
#
# Table name: course_classes
#
#  id                    :bigint(8)        not null, primary key
#  course_id             :bigint(8)        not null
#  section               :integer
#  canvas_course_id      :string
#  professor_name        :string
#  professor_email       :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  enrollments_loaded_at :datetime
#
# Indexes
#
#  index_course_classes_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
