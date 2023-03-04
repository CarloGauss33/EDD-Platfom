require 'rails_helper'

RSpec.describe 'Api::Internal::StudentsControllers', type: :request do
  describe 'POST /create' do
    let!(:user_attributes) { attributes_for(:user) }
    let!(:course_class) { create(:course_class) }

    let(:params) do
      {
        student: {
          user: user_attributes
        }
      }
    end

    let(:attributes) do
      JSON.parse(response.body)['student'].symbolize_keys
    end

    def perform
      post "/api/internal/courses/#{course_class.course.id}/course_classes/" \
           "#{course_class.id}/students", params: params
    end

    before do
      allow(CreateUserFromStudentJob).to receive(:perform_now).and_return(User.last)
    end

    it 'returns http success' do
      perform
      expect(response).to have_http_status(:success)
    end

    it 'calls CreateUserFromStudentJob' do
      perform
      expect(CreateUserFromStudentJob).to have_received(:perform_now)
    end
  end
end
