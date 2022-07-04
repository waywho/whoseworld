require "domain_constraints"

Rails.application.routes.draw do
  namespace :admin do
    root "sites#index"
    resources :sites
    resources :pages
  end
  resources :pages
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

  root "pages#landing"
end
