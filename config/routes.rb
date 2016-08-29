Rails.application.routes.draw do
  resources :activity_streams, only: [:show]
  resources :blogs
  resources :categories
  resources :users
  devise_for :users, controllers: { sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
