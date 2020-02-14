Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'pages/home'
  get 'pages/map'
  root to: 'pages#home'
  #root to: 'categories#index'
  resources :events, controller: :events, only: [:index, :show]
  resources :categories, controller: :categories, only: [:index, :show]
  resources :users, conroller: :users, only: :show

  # Service Worker Routes
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
end
