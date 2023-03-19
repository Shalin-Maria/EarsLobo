Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'
  get 'home', to: 'pages#home', as: 'home'
  get 'test', to: 'pages#test', as: 'test'
  get "/users/new", to: "users#new"
  get 'users', to: 'users#index'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'


  resources :users
  end


