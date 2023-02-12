Rails.application.routes.draw do
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
  resources :events do
    member do 
      get :delete
    end
  end
  
end
