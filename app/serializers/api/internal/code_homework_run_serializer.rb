class Api::Internal::CodeHomeworkRunSerializer < ActiveModel::Serializer
  type :code_homework_run
  belongs_to :code_homework

  attributes(
    :id,
    :status,
    :submitted_at,
    :graded_at,
    :run_results,
    :created_at,
    :updated_at
  )
end
