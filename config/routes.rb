Rails.application.routes.draw do
  namespace :api do
    get 'sessions/verify'
  end

  # TODO: add a root route
  get '/auth/:provider/callback' => 'sessions#authentication_callback'
  get '/item/:handle' => 'items#fetch'
  namespace :api do
    resources :auth_services, only: [:index, :show, :create, :update, :destroy]
    resources :auth_ip_addresses, only: [:index, :show, :create, :update, :destroy]
    resources :auth_ip_address_groups, only: [:index, :show, :create, :update, :destroy]
    resources :end_services, only: [:index, :show, :create, :update, :destroy]
    resources :items, only: [:index, :show, :create, :update, :destroy]
  end
end
