Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [ :index ]
  resources :carts, only: [ :update ]
  resources :orders, only: [ :new, :create ]

  root "products#index"
end
