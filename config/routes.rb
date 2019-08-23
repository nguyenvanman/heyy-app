Rails.application.routes.draw  do
  
  # get '/users', to: 'users#index'
  # get 'users/email/available', to: 'users#available'
  # get 'users/:id', to: 'users#show'
  # get 'users/:id/information', to: 'users#info'
  # post '/users/me/questions', to: 'users#update_question'

  scope 'users' do
    #get '/users', to: 'users#index'
    get 'email/available', to: 'users#available'
    get ':id/information', to: 'users#info'
    post 'me/questions', to: 'users#update_question'
  end
  
  # Authentication in admin page
  get '/login', to: 'authentication#new'
  post '/login',   to: 'authentication#create'
  delete '/logout',  to: 'authentication#destroy'
  
  # Authenticate with facebook
  post '/authenticate', to: 'authentication#authenticate'
  
  # Authentication api
  post '/sign_up', to: 'authentication#sign_up'
  post '/sign_in', to: 'authentication#sign_in'
  
  root 'authentication#new'

  resources :authentication, only: %i[authenticate new destroy sign_up]
  resources :users, only: %i[update_question index show available] 
end
