Rails.application.routes.draw do
  resources :reviews, only: [:index]
  resources :recipes, only: [:index]
  resources :posts, only: [:index]
  get 'activity_streams/prev/:id', to: 'activity_streams#prev', as: 'activity_stream_prev'
  resources :activity_streams, only: [:index, :show]
  get 'blogs/user/:user_id', to: 'blogs#by_user', as: 'blogs_by_user'
  resources :blogs
  resources :categories
  resources :users
  devise_for :users, controllers: { sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
