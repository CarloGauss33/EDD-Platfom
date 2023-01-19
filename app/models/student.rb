class Student < ApplicationRecord
  belongs_to :course_class
  belongs_to :user

  validates :user_id, uniqueness: { scope: :course_class_id }

  delegate :email, to: :user
  delegate :rut, to: :user
  delegate :github_username, to: :user
  delegate :full_name, to: :user
  delegate :section, to: :course_class

  enum status: { active: 0, inactive: 1, dropped: 2, completed: 3 }
end

# == Schema Information
#
# Table name: students
#
#  id                   :bigint(8)        not null, primary key
#  user_id              :bigint(8)        not null
#  course_class_id      :bigint(8)        not null
#  status               :integer          default("active")
#  canvas_enrollment_id :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_students_on_course_class_id  (course_class_id)
#  index_students_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_class_id => course_classes.id)
#  fk_rails_...  (user_id => users.id)
#
