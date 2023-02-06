class Api::Internal::CourseSerializer < ActiveModel::Serializer
  type :course

  attributes(
    :id,
    :name,
    :code,
    :description,
    :year,
    :season,
    :administrator_email
  )
end
