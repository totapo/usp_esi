Rails.application.routes.draw do
  resources :buses
  resources :drivers
  resources :employees
  resources :login
  resources :spots
  post 'select_driver', to:'buses#select_driver'
  post 'select_line', to:'buses#select_line'
  post 'remove_line', to:'buses#remove_line'
  post 'remove_driver', to:'buses#remove_driver'
  get 'lines', to: 'lines#index'
  post 'lines', to: 'lines#create'
  put 'lines/:id', to: 'lines#update'
  get 'lines/:id', to: 'lines#show'
  delete 'lines/:id', to: 'lines#destroy'
  get 'home', to: 'application#index'
  get '/', to: 'login#new'
  get 'logout', to: 'login#logout'
  root 'login#new'
  get 'main', to: 'application#main'
  get 'services/stops', to: 'services#stops'
  get 'services/lines', to: 'services#lines'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
