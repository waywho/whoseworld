require "domain_constraints"

Rails.application.routes.draw do
  resources :pages
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  constraints DomainConstraints.new("weihsihu.test", "weihsihu.com", "weihsihu.co.uk") do
    root to: "weihsihu/pages#landing", as: :weihsihu_root
  end

  constraints DomainConstraints.new("logical-thinking.co.uk", "logical-thinking.test") do
    root to: "logical_thinking/pages#landing", as: :logical_thinking_root
  end

  constraints DomainConstraints.new("storychor.com", "storychor.test") do
    root to: "storychor/pages#landing", as: :storychor_root
  end

  constraints DomainConstraints.new("berlinunrehearsedmusicals.com", "berlinunrehearsedmusicals.test") do
    root to: "burm/pages#landing", as: :burm_root
  end

  root "pages#landing"
end
