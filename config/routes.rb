Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: :json } do
    namespace :internal do
      resource :users, only: [:update]
      resources :assignment_question_responses
      resources :courses, only: [] do
        resources :course_classes, only: [] do
          resources :students, only: [:create]
        end
        resources :assignments, only: [:index, :show] do
          resource :assignment_responses, only: [:update]
          resources :assignment_questions, only: [:create, :update, :destroy] do
            resource :assignment_question_response, only: [:update, :create]
          end
        end
      end
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :assignments, only: [:index, :show] do
    resource :assignment_responses, only: [:show, :update]
  end
  resources :courses, only: [:index, :show] do
    resources :students, only: [:new]
  end

  get 'profile', to: 'users#show'
  get "/404", to: "errors#not_found", via: :all, as: :not_found
  get "/500", to: "errors#internal_server_error", via: :all, as: :internal_server_error
  root to: 'assignments#index'
end
