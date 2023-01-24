require 'rails_helper'

RSpec.describe 'Api::Internal::AssignmentQuestionResponsesControllers', type: :request do
  describe 'POST /create' do
    let!(:student) { create(:student) }
    let!(:assignment) { create(:assignment, course: student.course) }
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
           "/assignment_question_responses", params: params
    end

    before do
      sign_in student.user
      perform
    end

    it { expect(attributes.except(:file)).to eq(params[:assignment_question_response].except(:file)) }
    it { expect(response.status).to eq(201) }
  end

  describe 'PUT /update' do
    let!(:student) { create(:student) }
    let!(:assignment) { create(:assignment, course: student.course) }
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
          "/assignment_question_responses/#{assignment_question_response.id}", params: params
    end

    before do
      sign_in student.user
      perform
    end

    it { expect(attributes.except(:file)).to eq(params[:assignment_question_response].except(:file)) }
    it { expect(response.status).to eq(200) }
  end

  describe 'DELETE /destroy' do
    let!(:student) { create(:student) }
    let!(:assignment) { create(:assignment, course: student.course) }
    let!(:assignment_question) { create(:assignment_question, assignment: assignment) }
    let!(:assignment_question_response) do
      create(:assignment_question_response,
             assignment_question: assignment_question,
             assignment_response: student.assignment_responses.find_by(assignment: assignment))
    end

    def perform
      delete "/api/internal/courses/#{assignment.course.id}/assignments/" \
             "#{assignment.id}/assignment_questions/#{assignment_question.id}" \
             "/assignment_question_responses/#{assignment_question_response.id}"
    end

    before do
      sign_in student.user
      perform
    end

    it { expect(response.status).to eq(204) }
  end
end
