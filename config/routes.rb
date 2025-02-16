require "domain_constraints"

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) if ENV["ACTIVE_ADMIN_DISABLE_ROUTE"] != "true"
  
  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  constraints DomainConstraints.new("berlinunrehearsedmusicals.com", "berlinunrehearsedmusicals.test") do

    scope ":musical_id" do
      resources "signups", module: :burm, only: %i[show new create edit update destroy], as: "burm_signups"
    end

    resources "mailings", module: :burm, only: %i[new create edit], as: "burm_mailings" do
      get :unsubscribe, to: "mailings#unsubscribe"
    end

    scope "mailings" do
      get "confirm/:token", to: "burm/mailings#confirm", as: "burm_mailing_confirm"
    end
  end

  root "pages#landing"
  resources :pages, only: %i[index show], path: ''

  # example for route constraint
  # constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
  #   root to: "weihsihu/pages#landing", as: :weihsihu_root
  # end
end
