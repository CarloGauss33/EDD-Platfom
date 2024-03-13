class Student < ApplicationRecord
  after_create_commit :create_assignment_responses

  belongs_to :course_class
  belongs_to :user
  has_many :assignment_responses, dependent: :destroy
  has_many :code_homework_runs, dependent: :destroy

  validates :user_id, uniqueness: { scope: :course_class_id }

  delegate :email, to: :user
  delegate :rut, to: :user
  delegate :github_username, to: :user
  delegate :full_name, to: :user
  delegate :section, to: :course_class
  delegate :course, to: :course_class

  scope :by_user, ->(user) { where(user: user) }
  scope :by_course, ->(course) { joins(:course_class).where(course_classes: { course: course }) }

  def self.by_course_and_user(course, user)
    by_course(course).by_user(user).first
  end

  enum status: { active: 0, inactive: 1, dropped: 2, completed: 3 }

  private

  def create_assignment_responses
    course_class.assignments.each do |assignment|
      assignment_responses.create!(assignment: assignment)
    end
  end
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
