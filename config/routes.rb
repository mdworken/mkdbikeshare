Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stations, only: [:index]
  get '/stations/invalid', to: 'stations#invalid'
  get '/bikeshare_feed_processors/refresh', to: 'bikeshare_feed_processors#manually_refresh'  
  get '/home', to: 'home#index'
end
