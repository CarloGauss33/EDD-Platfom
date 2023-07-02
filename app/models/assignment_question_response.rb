class AssignmentQuestionResponse < ApplicationRecord
  include FileUploader::Attachment.new(:file)
  belongs_to :assignment_question
  belongs_to :assignment_response

  validates :assignment_question, presence: true
  validates :assignment_response, presence: true
  validates :file, presence: true
  validates :assignment_question, uniqueness: { scope: :assignment_response }

  delegate :student, to: :assignment_response
  delegate :title, to: :assignment_question, prefix: true

  enum status: {
    pending: 0,
    submitted: 1,
    graded: 2,
    cancelled: 3
  }
  delegate :url, to: :file, prefix: true

  def filename
    file['filename']
  end
end

# == Schema Information
#
# Table name: assignment_question_responses
#
#  id                     :bigint(8)        not null, primary key
#  assignment_response_id :bigint(8)        not null
#  assignment_question_id :bigint(8)        not null
#  score                  :float            default(0.0)
#  description            :string
#  file_data              :jsonb
#  status                 :integer          default("pending")
#  comment                :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_assignment_question_responses_on_assignment_question_id  (assignment_question_id)
#  index_assignment_question_responses_on_assignment_response_id  (assignment_response_id)
#  index_question_responses_on_question_id_and_response_id        (assignment_question_id,assignment_response_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (assignment_question_id => assignment_questions.id)
#  fk_rails_...  (assignment_response_id => assignment_responses.id)
#
