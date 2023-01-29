Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: :json } do
    namespace :internal do
      resources :assignment_question_responses
      resources :courses, only: [] do
        resources :assignments, only: [:index, :show] do
          resources :assignment_questions, only: [:create, :update, :destroy] do
            resource :assignment_question_response, only: [:update, :create]
          end
        end
      end
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount CoverImageUploader.derivation_endpoint => "/derivations/cover_image"

  resources :assignments, only: [:index, :show]
  root to: 'assignments#index'
end
