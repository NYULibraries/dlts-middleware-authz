Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'application#authentication_callback'

  namespace :api do
    resources :auth_services, only: [:index, :show, :create, :update, :destroy]
    resources :auth_ip_addresses, only: [:index, :show, :create, :update, :destroy]
    resources :end_services, only: [:index, :show, :create, :update, :destroy]
    resources :items, only: [:index, :show, :create, :update, :destroy]
  end
end
