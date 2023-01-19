class CourseClass < ApplicationRecord
  belongs_to :course

  has_many :students
  has_many :users, through: :students

  delegate :name, to: :course

  validates :section, uniqueness: { scope: :course_id }
end

# == Schema Information
#
# Table name: course_classes
#
#  id               :bigint(8)        not null, primary key
#  course_id        :bigint(8)        not null
#  section          :integer
#  canvas_course_id :string
#  professor_name   :string
#  professor_email  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_course_classes_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
