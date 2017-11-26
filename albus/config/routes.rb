Rails.application.routes.draw do
  resources :buses
  resources :drivers
  resources :employees
  resources :login
  resources :spots
  get 'lines', to: 'lines#index'
  post 'lines', to: 'lines#create'
  put 'lines', to: 'lines#update'
  get 'home', to: 'application#index'
  get '/', to: 'login#new'
  root 'login#new'
  get 'main', to: 'application#main'
  get 'services/stops', to: 'services#stops'
  get 'services/lines', to: 'services#lines'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
