Rails.application.routes.draw do


  get 'users/index'
  devise_for :users
  get 'pages/home'
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end

  root to: redirect('/home')
  get 'home', to: 'pages#home', as: 'home'
  get 'about', to: 'pages#about', as: 'about'
  
  get "/clients/new", to: "clients#new"
  get 'clients', to: 'clients#index'
  get 'clients/:id/edit', to: 'clients#edit', as: 'edit_client'
  get 'global_moderator_index', to: 'clients#global_moderator_index'
  
  get 'users', to:'users#index'
  get 'combined', to: 'clients#combined'

  get 'clinicians', to:'clinicians#index'

  get "/clinicians/new", to: "clinicians#new", as: 'new_clinician'
  get 'clinicians/:id/edit', to: 'clinicians#edit', as: 'edit_clinician'
  

  resources :users, only: [:index, :new, :create]

  resources :clients do
    resources :emergency_contacts, only: [:create, :destroy, :new, :edit, :update]
    resources :dwt_tests do
      collection do
        get 'new_dwt_list1', to: 'dwt_tests#new_dwt_list1', as: 'dwt_list1'
        get 'new_dwt_list2', to: 'dwt_tests#new_dwt_list2', as: 'dwt_list2'
        get 'new_dwt_list3', to: 'dwt_tests#new_dwt_list3', as: 'dwt_list3'
        get 'new_dwt_list4', to: 'dwt_tests#new_dwt_list4', as: 'dwt_list4'
        get 'dwt_tests/:id', to: 'dwt_tests#show', as: 'show'
      end
    end
    resources :dnw_tests do
      collection do
        get 'new_dnw_list1', to: 'dnw_tests#new_dnw_list1', as: 'dnw_list1'
        get 'new_dnw_list2', to: 'dnw_tests#new_dnw_list2', as: 'dnw_list2'
        get 'new_dnw_list3', to: 'dnw_tests#new_dnw_list3', as: 'dnw_list3'
        get 'new_dnw_list4', to: 'dnw_tests#new_dnw_list4', as: 'dnw_list4'
        get 'dnw_tests/:id', to: 'dnw_tests#show', as: 'show'
      end
    end
    resources :rddt_tests do
      collection do
        get 'new_rddt_list1', to: 'rddt_tests#new_rddt_list1', as: 'rddt_list1'
        get 'new_rddt_list2', to: 'rddt_tests#new_rddt_list2', as: 'rddt_list2'
        get 'rddt_tests/:id', to: 'rddt_tests#show', as: 'show'
      end
    end
  
 
 
  
    resources :week_ones do
      collection do
        get 'new_week_one_test_five', to: 'week_ones#new_week_one_test_five', as: 'week_one_test_five'
        get 'new_week_one_test_six', to: 'week_ones#new_week_one_test_six', as: 'week_one_test_six'
        get 'rddt_week_one_test1', to: 'week_ones#rddt_week_one_test1', as: 'week_one_test_one'
        get 'rddt_week_one_test2', to: 'week_ones#rddt_week_one_test2', as: 'week_one_test_two'
        get 'dwt_week_one_test3', to: 'week_ones#dwt_week_one_test3', as: 'week_one_test_three'
        get 'dwt_week_one_test4', to: 'week_ones#dwt_week_one_test4', as: 'week_one_test_four'
        get 'week_ones/:id', to: 'week_ones#show', as: 'show'
      end
    end
    end
    get 'clients/:client_id/trainings', to: 'trainings#index', as: 'client_trainings'
    get 'clients/:client_id/trainings/:id', to: 'tranings#show', as: 'client_traning'
    
end
