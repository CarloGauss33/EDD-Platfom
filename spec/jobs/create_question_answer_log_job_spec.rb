require 'rails_helper'

RSpec.describe CreateQuestionAnswerLogJob, type: :job do
  let(:question) { 'question' }
  let(:answer) { 'answer' }
  let(:caller_platform) { 'telegram' }
  let(:answer_origin) { 'openai' }

  def perform
    described_class.perform_now(
      question: question,
      answer: answer,
      caller_platform: caller_platform,
      answer_origin: answer_origin
    )
  end

  it 'creates a question answer log' do
    expect { perform }.to change { QuestionAnswerLog.count }.by(1)
  end

  it 'creates a question answer log with the correct attributes' do
    perform
    expect(QuestionAnswerLog.last).to have_attributes(
      question: question,
      answer: answer,
      caller_platform: caller_platform,
      answer_origin: answer_origin
    )
  end
end
