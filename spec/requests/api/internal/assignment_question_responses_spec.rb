require 'rails_helper'

RSpec.describe 'Api::Internal::AssignmentQuestionResponsesControllers', type: :request do
  describe 'POST /create' do
    let!(:student) { create(:student) }
    let!(:assignment) do
      create(:assignment,
             course: student.course,
             status: :active)
    end
    let!(:assignment_question) { create(:assignment_question, assignment: assignment) }

    let(:params) do
      {
        assignment_question_response: {
          comment: 'Some comment',
          description: 'Some description',
          file: Rack::Test::UploadedFile.new(
            Rails.root.join('spec/fixtures/edd.pdf'),
            'image/png'
          )
        }
      }
    end

    let(:attributes) do
      JSON.parse(response.body)['assignment_question_response'].symbolize_keys
    end

    def perform
      post "/api/internal/courses/#{assignment.course.id}/assignments/" \
           "#{assignment.id}/assignment_questions/#{assignment_question.id}" \
           "/assignment_question_response", params: params
    end

    context 'when the record is new' do
      before do
        sign_in student.user
        perform
      end

      it { expect(response.status).to eq(201) }

      it 'creates a new assignment question response' do
        expect(assignment_question.assignment_question_responses.count).to eq(1)
      end

      it 'returns the correct attributes' do
        expect(attributes).to include(
          id: AssignmentQuestionResponse.last.id,
          comment: 'Some comment',
          description: 'Some description',
          file: {
            url: AssignmentQuestionResponse.last.file_url,
            filename: 'edd.pdf'
          }.as_json
        )
      end
    end

    context 'when the record already exists' do
      let!(:assignment_question_response) do
        create(:assignment_question_response,
               assignment_question: assignment_question,
               assignment_response: student.assignment_responses.find_by(assignment: assignment))
      end

      before do
        sign_in student.user
        perform
      end

      it { expect(response.status).to eq(201) }

      it 'returns the correct attributes' do
        expect(attributes).to include(
          id: assignment_question_response.id,
          comment: 'Some comment',
          description: 'Some description'
        )
      end
    end

    context 'with an non active assignment' do
      before do
        assignment.update!(status: :completed)
        sign_in student.user
        perform
      end

      it { expect(response.status).to eq(422) }
    end
  end

  describe 'PUT /update' do
    let!(:student) { create(:student) }
    let!(:assignment) do
      create(:assignment,
             course: student.course,
             status: :active)
    end
    let!(:assignment_question) { create(:assignment_question, assignment: assignment) }
    let!(:assignment_question_response) do
      create(:assignment_question_response,
             assignment_question: assignment_question,
             assignment_response: student.assignment_responses.find_by(assignment: assignment))
    end

    let(:params) do
      {
        assignment_question_response: {
          comment: 'Some comment',
          description: 'Some description',
          file: Rack::Test::UploadedFile.new(
            Rails.root.join('spec/fixtures/edd.pdf'),
            'image/png'
          )
        }
      }
    end

    let(:attributes) do
      JSON.parse(response.body)['assignment_question_response'].symbolize_keys
    end

    def perform
      put "/api/internal/courses/#{assignment.course.id}/assignments/" \
          "#{assignment.id}/assignment_questions/#{assignment_question.id}" \
          "/assignment_question_response", params: params
    end

    context 'with valid assignment' do
      before do
        sign_in student.user
        perform
      end

      it 'updates the assignment question response attributes' do
        expect(assignment_question_response.reload.comment).to eq('Some comment')
        expect(assignment_question_response.reload.description).to eq('Some description')
      end

      it { expect(response.status).to eq(200) }
    end

    context 'with an non active assignment' do
      before do
        assignment.update!(status: :completed)
        sign_in student.user
        perform
      end

      it { expect(response.status).to eq(422) }
    end
  end
end
