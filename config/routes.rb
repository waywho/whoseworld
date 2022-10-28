require "domain_constraints"

Rails.application.routes.draw do
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  namespace :manage, module: 'admin', as: :admin do
    resources :medias
    resources :galleries do
      member do
        delete :delete_image
      end
    end
    root "sites#index"
    resources :sites
    resources :pages
    resources :contents do
      member do
        delete :delete_image
      end
    end
  end

  root "pages#landing"
  resources :pages, only: %i[index show], path: ''
  devise_for :users, path: 'manage'



  # example for route constraint
  # constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
  #   root to: "weihsihu/pages#landing", as: :weihsihu_root
  # end
end
