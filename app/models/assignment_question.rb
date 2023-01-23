class AssignmentQuestion < ApplicationRecord
  belongs_to :assignment
  has_many :assignment_question_responses, dependent: :destroy

  scope :by_assignment, ->(assignment_id) { where(assignment_id: assignment_id) }

  enum question_type: { text: 0, file: 1 }
end

# == Schema Information
#
# Table name: assignment_questions
#
#  id            :bigint(8)        not null, primary key
#  assignment_id :bigint(8)        not null
#  question_type :integer
#  title         :string
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_assignment_questions_on_assignment_id  (assignment_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_id => assignments.id)
#
