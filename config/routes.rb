Rails.application.routes.draw do
  post '/authenticate', to: 'authentication#authenticate'
  resources :authentication, only: [:authenticate]
end
