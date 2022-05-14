require "domain_constraints"

Rails.application.routes.draw do
  resources :pages
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # constraints DomainConstraints.new('weihsihu.com') do
  #   root to: 'mydomain#index'
  # end

  # constraints DomainConstraints.new('logical-thinking.co.uk') do
  #   root to: 'mydomain#index'
  # end

  # constraints DomainConstraints.new('storychor.com') do
  #   root to: 'mydomain#index'
  # end

  # constraints DomainConstraints.new('berlinunrehearsedmusicals.com') do
  #   root to: 'mydomain#index'
  # end

  root "pages#landing"
end
