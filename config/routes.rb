Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "/", to: "home#index", as: :home

  resources :boards, only: [ :index, :show, :create, :update, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
