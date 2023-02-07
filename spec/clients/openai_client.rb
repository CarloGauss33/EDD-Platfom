require 'rails_helper'
require 'ruby/openai'

Rspec.describe OpenaiClient, type: :client do
  let(:openai_client) { instance_double(OpenAI::Client) }

  context 'when openai is not enabled' do
    before do
      allow(ConfigVariable).to receive(:get_value).with('OPENAI_ENABLED').and_return(false)
    end

    it 'returns a message' do
      expect(openai_client.get_completion(prompt)).to eq('OpenAI not enabled')
    end
  end

  context 'when openai is enabled' do
    before do
      allow(ConfigVariable).to receive(:get_value).with('OPENAI_ENABLED').and_return(true)
      allow(ENV).to receive(:fetch).with('OPENAI_API_KEY', nil).and_return('test')
    end

    it 'calls the openai client' do
      expect(OpenAI::Client).to have_received(:new)
    end
  end
end
