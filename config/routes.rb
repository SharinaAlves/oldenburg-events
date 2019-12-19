Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  #root to: 'pages#home'
  root to: 'categories#index'
  resources :events, controller: :events, only: [:index, :show]
  resources :categories, controller: :categories, only: :index
end
