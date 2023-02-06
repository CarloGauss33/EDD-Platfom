require 'rails_helper'

RSpec.describe Telegram::BroadcastMessageJob, type: :job do
  let(:message) { 'message' }
  let(:chat_id ) { 'chat_id' }
  let(:broadcast_recipients_chat_ids) { chat_id }
  let(:client) { instance_double(Telegram::Bot::Client) }

  before do
    allow(ConfigVariable)
      .to receive(:fetch)
      .with('TELEGRAM_BROADCAST_RECIPIENTS_CHAT_IDS', [])
      .and_return(broadcast_recipients_chat_ids)

    allow(Telegram.bots).to receive(:[]).with(:default).and_return(client)
    allow(client).to receive(:send_message).with(chat_id: chat_id, text: message)
  end

  def perform
    described_class.perform_now(message)
  end

  it 'broadcasts the message to the recipients' do
    perform
    expect(client).to have_received(:send_message).with(chat_id: chat_id, text: message)
  end
end
