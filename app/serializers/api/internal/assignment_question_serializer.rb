class Api::Internal::AssignmentQuestionSerializer < ActiveModel::Serializer
  type :assignment_question

  attributes(
    :id,
    :title,
    :slugged_title,
    :description,
    :question_type
  )

  def slugged_title
    object.title.parameterize
  end
end
