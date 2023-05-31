Rails.application.routes.draw do


  get 'users/index'
  devise_for :users
  get 'pages/home'
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end

  root to: redirect('/home')
  get 'home', to: 'pages#home', as: 'home'
  get 'test', to: 'pages#test', as: 'test'
  get "/clients/new", to: "clients#new"
  get 'clients', to: 'clients#index'
  get 'clients/:id/edit', to: 'clients#edit', as: 'edit_client'
  
  
  get 'users', to:'users#index'
  get 'combined', to: 'clients#combined'

  get 'clinicians', to:'clinicians#index'

  get "/clinicians/new", to: "clinicians#new", as: 'new_clinician'
  get 'clinicians/:id/edit', to: 'clinicians#edit', as: 'edit_clinician'
  


  
  resources :clients do
    resources :emergency_contacts, only: [:create, :destroy, :new, :edit, :update]
    resources :tests do
      collection do
        get 'new_dwt_list2'
        get 'new_dwt_list3'
        get 'new_dwt_list4'
        get 'new_dnw_list1'
        get 'new_dnw_list2'
        get 'new_dnw_list3'
        get 'new_dnw_list4'
        get 'new_rddt_list1'
        get 'new_rddt_list2'
      end
    end
  end
  resources :tests, only: [:edit, :update, :destroy]

end
