class Api::Internal::CodeHomeworkSerializer < ActiveModel::Serializer
  type :code_homework
  belongs_to :course

  attributes(
    :id,
    :name,
    :homework_url,
    :start_date,
    :end_date,
    :repository_prefix,
    :testcases_url,
    :course
  )

  def course
    object.course
  end
end
