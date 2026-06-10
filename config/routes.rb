Rails.application.routes.draw do
  get "reports/index"
  resources :responses
  resources :forms
  resources :templates
  resources :sessions, only: [:new, :create, :destroy]
  resources :imports, only: [:new, :create]
  resource :password, only: [:edit, :update]
end
