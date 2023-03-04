Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  telegram_webhook Telegram::WebhookController
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: :json } do
    namespace :internal do
      resources :assignment_question_responses
      resources :courses, only: [] do
        resources :course_classes, only: [] do
          resources :students, only: [:create]
        end
        resources :assignments, only: [:index, :show] do
          resources :assignment_questions, only: [:create, :update, :destroy] do
            resource :assignment_question_response, only: [:update, :create]
          end
        end
      end
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :assignments, only: [:index, :show]

  root to: 'assignments#index'
end
