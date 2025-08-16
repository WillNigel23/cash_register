Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [ :index ]
  resources :carts, only: [ :update ]

  root "products#index"
end
