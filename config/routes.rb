Rails.application.routes.draw do
  resources :member_events
  
  root "main#index"

  # root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end


  get 'main/index'
  # get 'members/index'
  # get 'members/new'
  # get 'members/edit'

  resources :members do
    member do
      get :delete
    end
  end

  resources :committees
  resources :excuses do 
    member do
      get :delete
    end
  end

  resources :committees do
    member do
      get :delete
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :events do
    member do 
      get :delete
    end
  end
  
  resources :events

end