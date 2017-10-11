Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  resources :users, only: [:new, :create]
  resources :main, only: [:index]

  controller :sessions do
    get 'login', to: 'sessions#new'
    post 'sessions', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
end
