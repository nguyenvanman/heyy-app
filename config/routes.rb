Rails.application.routes.draw  do
  post '/authenticate', to: 'authentication#authenticate'
  get '/login', to: 'authentication#new'
  post '/login',   to: 'authentication#create'
  root 'authentication#new'
  get '/users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  post '/users/me/questions', to: 'users#update_question'
  post '/sign_up', to: 'authentication#sign_up'
  post '/sign_in', to: 'authentication#sign_in'
  delete '/logout',  to: 'authentication#destroy'
  resources :authentication, only: [:authenticate, :new, :destroy, :sign_up]
  resources :users, only: %i[update_question index show]
end
