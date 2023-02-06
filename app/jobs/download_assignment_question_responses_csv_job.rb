class DownloadAssignmentQuestionResponsesCsvJob < ApplicationJob
  queue_as :default

  def perform(assignments_question_id)
    @assignment_question = AssignmentQuestion.find_by(id: assignments_question_id)

    return unless @assignment_question

    CSV.generate(headers: true) do |csv|
      csv << csv_headers

      assignment_question_responses.each do |assignment_question_response|
        csv << csv_row(assignment_question_response)
      end
    end
  end

  private

  def assignment_question_responses
    @assignment_question_responses ||= @assignment_question.assignment_question_responses.includes(assignment_response: :student)
  end

  def csv_headers
    %w[Nombre Email NombreArchivo EnlaceArchivo]
  end

  def csv_row(assignment_question_response)
    [
      assignment_question_response.student.full_name,
      assignment_question_response.student.email,
      assignment_question_response.file.original_filename,
      assignment_question_response.file.url
    ]
  end
end
