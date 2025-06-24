Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "/", to: "home#index", as: :home

  resources :boards, only: %i[index show create update destroy] do
    resources :columns, only: %i[create update destroy] do
      patch :reorder, on: :collection
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
