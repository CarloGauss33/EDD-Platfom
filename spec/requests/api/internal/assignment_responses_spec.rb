require 'rails_helper'

RSpec.describe 'Api::Internal::AssignmentResponsesControllers', type: :request do
  describe 'PUT ' do
    let!(:student) { create(:student) }
    let!(:course) { student.course }
    let!(:assignment) do
      create(:assignment,
             course: course,
             status: :active)
    end
    let(:user) { student.user }
    let(:assignment_response) { student.assignment_responses.first }

    context 'when user is not logged in' do
      before do
        put "/api/internal/courses/#{course.id}/assignments/#{assignment.id}/assignment_responses"
      end

      it 'returns 401' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is logged in' do
      before do
        sign_in user
        put "/api/internal/courses/#{course.id}/assignments/#{assignment.id}/assignment_responses"
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
