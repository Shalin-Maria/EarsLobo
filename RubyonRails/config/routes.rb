Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  root 'pages#home'
  get 'home', to: 'pages#home', as: 'home'
  get 'test', to: 'pages#test', as: 'test'
  get "/clients/new", to: "clients#new"
  get 'clients', to: 'clients#index'
  get 'clients/:id/edit', to: 'clients#edit', as: 'edit_client'
  get 'combined', to: 'clients#combined'

  get 'clinicians', to:'clinicians#index'
  get "/clinicians/new", to: "clinicians#new", as: 'new_clinician'
  get 'clinicians/:id/edit', to: 'clinicians#edit', as: 'edit_clinician'
  

  resources :clients do
    resources :emergency_contacts, only: [:create, :destroy, :new, :edit, :update]
    get 'test_new', on: :collection
  end
end

