require "domain_constraints"

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) if ENV["ACTIVE_ADMIN_DISABLE_ROUTE"] != "true"
  
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  constraints DomainConstraints.new("berlinunrehearsedmusicals.com", "berlinunrehearsedmusicals.test") do
    scope ":musical_id", module: "burm" do
      resources "signups", only: %i[new create edit update destroy], as: "burm_signups"
      get "signups/not_open", to: "signups#show", as: "burm_signups_not_open"
    end
  end

  root "pages#landing"
  resources :pages, only: %i[index show], path: ''

  # example for route constraint
  # constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
  #   root to: "weihsihu/pages#landing", as: :weihsihu_root
  # end
end
