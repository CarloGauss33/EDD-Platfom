Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: :json } do
    namespace :internal do
    end
  end
  devise_for :users
  mount CoverImageUploader.derivation_endpoint => "/derivations/cover_image"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
