Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stations, only: [:index]
  get '/stations/invalid', to: 'stations#invalid'
  get '/capital_input/update', to: 'capital_input#update'
  get '/tester/:station_id', to: 'stations#get_info_by_id'

  root 'profile#index'
end
