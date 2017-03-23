Rails.application.routes.draw do
  # TODO: use a real root route
  root to: 'items#get'
  get '/auth/:provider/callback' => 'sessions#authentication_callback'
  get '/item/get/:id' => 'items#get'
  namespace :api do
    resources :auth_services, only: [:index, :show, :create, :update, :destroy]
    resources :auth_ip_addresses, only: [:index, :show, :create, :update, :destroy]
    resources :auth_ip_address_groups, only: [:index, :show, :create, :update, :destroy]
    resources :end_services, only: [:index, :show, :create, :update, :destroy]
    resources :items, only: [:index, :show, :create, :update, :destroy]
  end
end
