Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stations, only: [:index]
  get '/stations/invalid', to: 'stations#invalid'
  get '/capital_inputs/refresh', to: 'capital_inputs#manually_refresh'
  get '/tester/:station_id', to: 'stations#get_info_by_id'
  
  root 'profile#index'
end
