# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  constraints(lambda { |req| req.format == :json }) do
    resources :tasks, except: %i[new edit], param: :slug
    resources :users, only: %i[index create]
    resource :session, only: %i[create destroy]
    resources :comments, only: %i[create]
    resource :preference, only: %i[show update] do
      patch :mail, on: :member
    end
  end

  root "home#index"
  get "*path", to: "home#index", via: :all
  # Defines the root path route ("/")
  # root "posts#index"
end
