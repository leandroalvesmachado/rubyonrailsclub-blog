# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  get "welcome/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "welcome#index"

  resources :articles, only: [:show] do
    resources :comments do
      member do
        post :like
        post :dislike
      end
    end
  end

  namespace :administrate do
    get "/" => "dashboards#index"

    resources :articles do
      member do
        delete :destroy_cover_image
      end
    end

    resources :authors do
      member do
        delete :destroy_avatar_image
      end
    end

    resources :categories do
      member do
        delete :destroy_cover_image
      end
    end
  end
end
