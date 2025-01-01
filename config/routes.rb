require "domain_constraints"

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) if ENV["ACTIVE_ADMIN_DISABLE_ROUTE"] != "true"
  
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # namespace :admin, module: 'admin', as: :admin do
  #   root "sites#index"
  #   resources :sites

  #   get "/:site_id/pages/:id", to: "pages#show", as: :preview_page

  #   scope "(:site_id)" do
  #     resources :medias
  #     resources :galleries do
  #       member do
  #         delete :delete_image
  #       end
  #     end

  #     resources :pages, only: %i[index new create edit update destroy]
  #     resources :contents do
  #       member do
  #         delete :delete_image
  #       end
  #     end
  #   end
  # end

  root "pages#landing"
  resources :pages, only: %i[index show], path: ''

  # example for route constraint
  # constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
  #   root to: "weihsihu/pages#landing", as: :weihsihu_root
  # end
end
