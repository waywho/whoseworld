require "domain_constraints"

Rails.application.routes.draw do
  namespace :admin do
    root "admin/sites#index"
    resources :pages
    resources :sites
  end
  resources :pages
  devise_for :users, path: 'admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
  #   root to: "pages#landing", as: :weihsihu_root
  # end

  # constraints DomainConstraints.new("logical-thinking.co.uk", "logical-thinking.test") do
  #   root to: "pages#landing", as: :logical_thinking_root
  # end

  # constraints DomainConstraints.new("storychor.com", "storychor.test") do
  #   root to: "pages#landing", as: :storychor_root
  # end

  # constraints DomainConstraints.new("berlinunrehearsedmusicals.com", "berlinunrehearsedmusicals.test") do
  #   root to: "pages#landing", as: :burm_root
  # end

  root "pages#landing"
end
