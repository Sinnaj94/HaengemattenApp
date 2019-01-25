Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :sizes
  get 'sites/list', to: 'sites#list', as: 'list_sites'
  resources :sites
  resources :reviews
  resources :users do
    member do
      post :promote
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :sites, only: [:index, :create, :show, :update, :destroy]
      resources :reviews, only: [:index, :create, :show, :update, :destroy]
    end
  end
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  get 'admin', to: 'home#admin', as: 'admin'
  get 'profile', to: 'home#profile', as: 'profile'
end
