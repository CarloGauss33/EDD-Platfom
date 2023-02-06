class Telegram::WebhookController < Telegram::Bot::UpdatesController
  def message(message); end

  def start!(data = nil, *)
    response = from ? "Hola #{username}!" : 'Hola!'

    respond_with :message, text: response
  end

  private

  def username
    @username ||= from['username']
  end
end
