Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :vehicles
  resources :statuses
  resources :transitions

  resources :orders do
    member do
      post 'assign'
    end
    collection do
      get 'my'
    end
  end

  get 'profile', to: 'user#profile'
  put 'user/update', to: 'user#update' 
  post 'auth/login', to: 'authentication#authenticate'

  ActiveAdmin.routes(self)
end
