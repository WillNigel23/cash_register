Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [ :index ]
  resources :carts, only: [ :update ] do
    delete :remove_product, on: :collection
  end
  resources :orders, only: [ :new, :create ]

  root "products#index"
end
