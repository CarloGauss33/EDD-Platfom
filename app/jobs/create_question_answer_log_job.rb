class CreateQuestionAnswerLogJob < ApplicationJob
  queue_as :default

  def perform(
    caller_id: nil,
    question: nil,
    answer: nil,
    caller_platform: 'telegram',
    answer_origin: 'openai'
  )

    QuestionAnswerLog.create!(
      caller_platform: caller_platform,
      caller_id: caller_id,
      question: question,
      answer: answer,
      answer_origin: answer_origin
    )
  end
end
