require 'rails_helper'

RSpec.describe DownloadAssignmentQuestionResponsesCsvJob, type: :job do
  let(:assignment) { create(:assignment) }
  let!(:assignment_response) { create(:assignment_response, assignment: assignment) }
  let(:assignment_question) { create(:assignment_question, assignment: assignment) }
  let(:user) { assignment_response.student.user }
  let!(:assignment_question_response) do
    create(
      :assignment_question_response,
      assignment_question: assignment_question,
      assignment_response: assignment_response
    )
  end

  def perform
    described_class.perform_now(assignment_question.id)
  end

  it 'generates a csv file' do
    expect(perform).to be_a(String)
  end

  it 'generates a csv file with the correct headers' do
    expect(CSV.parse(perform).first).to eq(%w[Nombre Email NombreArchivo EnlaceArchivo])
  end

  it 'generates a csv file with the correct data' do
    expect(CSV.parse(perform)[1]).to eq(
      [
        user.full_name,
        user.email,
        assignment_question_response.file.original_filename,
        assignment_question_response.file.url
      ]
    )
  end
end
