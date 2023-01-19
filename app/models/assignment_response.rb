class AssignmentResponse < ApplicationRecord
  belongs_to :assignment
  belongs_to :student

  has_many :assignment_response_documents, dependent: :destroy
  accepts_nested_attributes_for :assignment_response_documents, allow_destroy: true

  enum status: {
    pending: 0,
    submitted: 1,
    graded: 2,
    completed: 3
  }

  validates :assignment_id, uniqueness: { scope: :student_id }
end

# == Schema Information
#
# Table name: assignment_responses
#
#  id            :bigint(8)        not null, primary key
#  assignment_id :bigint(8)        not null
#  student_id    :bigint(8)        not null
#  status        :integer
#  final_score   :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_assignment_responses_on_assignment_id  (assignment_id)
#  index_assignment_responses_on_student_id     (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_id => assignments.id)
#  fk_rails_...  (student_id => students.id)
#
