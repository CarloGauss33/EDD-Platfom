class Api::Internal::AssignmentSerializer < ActiveModel::Serializer
  type :assignment
  belongs_to :course

  attributes(
    :id,
    :name,
    :description,
    :status,
    :start_date,
    :end_date,
    :kind,
    :course
  )

  def course
    object.course
  end
end
