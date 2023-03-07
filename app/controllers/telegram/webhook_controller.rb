class Telegram::WebhookController < Telegram::Bot::UpdatesController
  DEFAULT_COURSE_ID = ConfigVariable.fetch('TELEGRAM_DEFAULT_COURSE_ID', -1)

  def message(message); end

  def start!(*)
    response = from ? "Hola #{username}!" : 'Hola!'

    respond_with :message, text: response
  end

  def question!(*words)
    full_question = words.join(' ')
    return respond_with :message, text: 'Debes ingresar una pregunta' if full_question.blank?

    response = Openai::SendOpenaiQuestionResponseJob.perform_now(full_question)

    CreateQuestionAnswerLogJob.perform_now(
      caller_id: from['id'],
      question: full_question,
      answer: response,
      caller_platform: 'telegram',
      answer_origin: 'openai'
    )

    respond_with :message, text: response
  end

  private

  def username
    @username ||= from['username']
  end

  def course
    @course ||= @course_code ? Course.find_by(code: @course_code) : Course.find_by(id: DEFAULT_COURSE_ID)
  end
end
