require "domain_constraints"

Rails.application.routes.draw do
  namespace :admin do
    resources :galleries do
      member do
        delete :delete_image
      end
    end
    root "sites#index"
    resources :sites
    resources :pages
  end
  root "pages#landing"
  resources :pages, only: %i[index show], path: ''
  devise_for :users, path: 'admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # example for route constraint
  # constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
  #   root to: "weihsihu/pages#landing", as: :weihsihu_root
  # end
end
