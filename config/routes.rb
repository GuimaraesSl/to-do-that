Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "/", to: "home#index", as: :home

  resources :boards, only: [ :index, :show, :create, :update, :destroy ] do
    resources :columns, only: [ :create, :update, :destroy ] do
      patch :reorder, on: :collection
      resources :tasks, only: [ :create, :show, :update, :destroy ] do
        member do
          patch :move
        end
      end
    end
  end

  resources :columns, only: [] do
    patch :reorder_tasks, to: "tasks#reorder", as: :reorder_column_tasks
    resources :tasks, only: [ :create, :show, :update, :destroy ] do
      member do
        patch :move
      end
    end
  end

  resources :tags, only: [ :index, :create, :destroy ]

  resources :taggings, only: [ :create, :destroy ] do
    delete :delete, on: :collection, as: :delete
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
