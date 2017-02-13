Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  get "static_pages/*page", to: "static_pages#show"

  namespace :admin do
    resources :categories
    resources :words, only: [:create, :update]
  end
  resources :users
end
