Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: 'pages#home'
  resources :events, controller: :events, only: [:index, :show]
end
