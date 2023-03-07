class Api::Internal::AssignmentResponseSerializer < ActiveModel::Serializer
  type :assignment_response
  belongs_to :assignment
  belongs_to :student

  attributes(
    :id,
    :assignment_id,
    :student_id,
    :status
  )

  def course
    object.course
  end
end
