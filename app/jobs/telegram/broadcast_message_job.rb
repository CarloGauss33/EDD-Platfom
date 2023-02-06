class Telegram::BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    broadcast_recipients_chat_ids.each do |chat_id|
      client.send_message(
        chat_id: chat_id,
        text: message
      )
    end
  end

  private

  def broadcast_recipients_chat_ids
    ConfigVariable.fetch('TELEGRAM_BROADCAST_RECIPIENTS_CHAT_IDS', []).split(',')
  end

  def client
    @client ||= Telegram.bots[:default]
  end
end
