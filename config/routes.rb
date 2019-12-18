Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  get 'events/index'
  get 'events/show'
  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: 'pages#home'
  root to: 'events#index'
  resources :events, controller: :events, only: [:index, :show]
end
