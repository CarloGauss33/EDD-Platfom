class Api::Internal::AssignmentQuestionResponseSerializer < ActiveModel::Serializer
  type :assignment_question_response

  attributes(
    :id,
    :assignment_question_id,
    :description,
    :file,
    :comment
  )

  def file
    if object.file.present?
      {
        url: object.file_url,
        filename: object.file.original_filename
      }
    end
  end
end
