Rails.application.routes.draw do
  resources :buses
  resources :drivers
  resources :employees
  resources :login
  resources :spots
  get 'home', to: 'application#index'
  get '/', to: 'login#new'
  root 'login#new'
  get 'main', to: 'application#main'
  get 'services/stops', to: 'services#stops'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
