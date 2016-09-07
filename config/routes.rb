Rails.application.routes.draw do
  get 'activity_streams/prev/:id', to:'activity_streams#prev', as: 'activity_stream_prev'
  resources :posts, only: [:index, :show]
  resources :activity_streams, only: [:index, :show]
  resources :blogs
  resources :categories
  resources :users
  devise_for :users, controllers: { sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
