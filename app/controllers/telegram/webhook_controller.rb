class Telegram::WebhookController < Telegram::Bot::UpdatesController
  DEFAULT_COURSE_ID = ConfigVariable.fetch('TELEGRAM_DEFAULT_COURSE_ID', -1)

  def message(message); end

  def start!(*)
    response = from ? "Hola #{username}!" : 'Hola!'

    respond_with :message, text: response
  end

  def summary!(course_code = nil)
    @course_code = course_code
    message = course ? course.summary : 'No se encontró el curso'

    respond_with :message, text: message, parse_mode: 'Markdown'
  end

  private

  def username
    @username ||= from['username']
  end

  def course
    @course ||= @course_code ? Course.find_by(code: @course_code) : Course.find_by(id: DEFAULT_COURSE_ID)
  end
end
