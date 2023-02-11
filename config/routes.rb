Rails.application.routes.draw do
  resources :member_events
  root "main#index"

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
  resources :excuses

  resources :committees do
    member do
      get :delete
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :events

end
