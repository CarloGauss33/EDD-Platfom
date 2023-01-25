class Api::Internal::AssignmentSerializer < ActiveModel::Serializer
  type :assignment

  attributes(
    :id,
    :name,
    :description,
    :start_date,
    :end_date,
    :kind
  )
end
