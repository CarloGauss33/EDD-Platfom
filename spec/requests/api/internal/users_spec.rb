require 'rails_helper'

RSpec.describe 'Api::Internal::UsersController', type: :request do
  describe 'PUT /update' do
    context 'when the user is not logged in' do
      it 'returns http unauthorized' do
        put '/api/internal/users'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the user is logged in' do
      let!(:user) { create(:user) }
      let(:params) do
        {
          user: {
            rut: '12345678-9'
          }
        }
      end

      before do
        sign_in user
      end

      it 'returns http success' do
        put '/api/internal/users', params: params
        expect(response).to have_http_status(:success)
      end

      it 'updates the user' do
        put '/api/internal/users', params: params
        expect(user.reload.rut).to eq('12345678-9')
      end
    end
  end
end
