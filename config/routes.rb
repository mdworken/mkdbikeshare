Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'location_query#slack_query'


  resources :stations, only: [:index]
  get '/stations/invalid', to: 'stations#invalid'
  get '/bikeshare_feed_processors/refresh', to: 'bikeshare_feed_processors#manually_refresh'  
  get '/home', to: 'home#index'
end
