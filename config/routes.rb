Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'authorizations/authorize'
      post 'authorizations/request_token'
      get 'authorizations/access_token'
      get 'users/me'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  resources :users, only: [:new, :create]
  resources :main, only: [:index]
  resource :profile
  resources :websites

  get 'regenerate_secrets/:id', to: 'websites#regenerate_secrets', as: 'secrets'

  controller :sessions do
    get 'login', to: 'sessions#new'
    post 'sessions', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'
  end
end
