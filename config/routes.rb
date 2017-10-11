Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create]
  controller :sessions do
    get 'login', to: 'sessions#new'
    post 'sessions', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
end