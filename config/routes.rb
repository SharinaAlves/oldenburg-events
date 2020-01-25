Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'pages/home'
  root to: 'pages#home'
  #root to: 'categories#index'
  resources :events, controller: :events, only: [:index, :show]
  resources :categories, controller: :categories, only: :index
end
