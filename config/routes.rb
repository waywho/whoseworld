Rails.application.routes.draw do
  resources :pages
  devise_for :users
  resources :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "accounts#index"
end
