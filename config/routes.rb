Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  get "static_pages/*page", to: "static_pages#show"

  get :admin, to: 'admin/dashboard#index'
  namespace :admin do
    resources :categories
    resources :words, only: [:create, :update, :destroy]
    resources :users, only: [:index, :show, :destroy]
  end
  resources :categories, only: [:index, :show] do
    resources :lessons, only: :show
  end
  resources :lessons, only: [:create, :update]
  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :activities
end
