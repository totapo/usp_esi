Rails.application.routes.draw do
  resources :onibuses
  resources :motorista
  resources :funcionarios
  get 'home', to: 'application#index'
  get '/', to: 'application#index'
  root 'application#index'
  get 'main', to: 'application#main'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
