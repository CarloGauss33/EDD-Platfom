class Api::Internal::CourseClassSerializer < ActiveModel::Serializer
  type :course_class

  attributes(
    :id,
    :course_id,
    :section,
    :professor_name,
    :professor_email
  )
end
