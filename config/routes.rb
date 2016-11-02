Rails.application.routes.draw do
  root 'messages#index'

  resources :users, only: [:new, :create]
  resources :messages, only: [:index, :create]

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
