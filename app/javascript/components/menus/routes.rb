Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :menus, only: [:index, :create, :update, :destroy]
    end
  end
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :pets, only: [:index, :show]
    end
  end
  root 'home#index'

  namespace :api, format: 'json' do
    namespace :v1 do
      get 'bookings/month', to: 'bookings#month'
      get 'bookings/menus', to: 'bookings#menus'
      get 'auth/create'
      get 'bookings/oneday', to: 'bookings#oneday'
      resources :bookings, only: [:index, :show, :new, :create]

    end
  end

  get '/employees/bookings/', to: 'home#index'
  get '/employees/bookings/:id', to: 'home#index'
  get '/employees/bookings/new/', to: 'home#index'

  get '/employees/charts/', to: 'home#index'
  get '/employees/charts/:id', to: 'home#index'

  get '/employees/settings/', to: 'home#index'
end