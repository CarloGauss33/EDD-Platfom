require 'rails_helper'

RSpec.describe Openai::SendOpenaiQuestionResponseJob, type: :job do
  let!(:openai_client) { instance_double(OpenaiClient) }

  before do
    allow(OpenaiClient).to receive(:new).and_return(openai_client)
    allow(openai_client).to receive(:get_completion).and_return('completion')
    allow(openai_client).to receive(:get_chat_completion).and_return('chat')
  end

  def perform(strategy = :chat)
    described_class.perform_now('question', strategy)
  end

  context 'when strategy is not present' do
    it 'returns chat strategy' do
      expect(perform).to eq('chat')
    end

    it 'calls get_chat_completion' do
      perform
      expect(openai_client).to have_received(:get_chat_completion)
    end
  end

  context 'when strategy is completion' do
    it 'returns completion strategy' do
      expect(perform(:completion)).to eq('completion')
    end

    it 'calls get_completion' do
      perform(:completion)
      expect(openai_client).to have_received(:get_completion)
    end
  end
end
