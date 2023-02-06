require 'rails_helper'

RSpec.describe Openai::SendOpenaiQuestionResponseJob, type: :job do
  let!(:openai_client) { instance_double(OpenaiClient) }

  before do
    allow(OpenaiClient).to receive(:new).and_return(openai_client)
    allow(openai_client).to receive(:get_completion).and_return('response')
  end

  def perform
    described_class.perform_now('question')
  end

  it 'calls the openai client' do
    perform
    expect(openai_client).to have_received(:get_completion)
  end

  it 'returns the response' do
    expect(perform).to eq('response')
  end
end
