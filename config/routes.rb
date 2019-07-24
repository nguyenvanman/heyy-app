Rails.application.routes.draw  do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post '/authenticate', to: 'authentication#authenticate'
  get '/login', to: 'authentication#new'
  post '/login',   to: 'authentication#create'
  root 'authentication#new'
  get '/users', to: 'users#index'
  delete '/logout',  to: 'authentication#destroy'
  resources :authentication, only: [:authenticate, :new, :destroy]
  resources :users
end
