Rails.application.routes.draw  do
  default_url_options host: 'localhost:3000'

  scope 'users' do
    get 'email/available',          to: 'users#available'
    get ':id/information',          to: 'users#info'

    scope 'me' do
      scope 'questions' do
        post '', to: 'questions#update'
        get ':question_id/history', to: 'questions#history' 
      end 

      scope 'saved_contents' do
        post '', to: 'saved_contents#create'
        get '', to: 'saved_contents#index'
      end
    end

    post 'password/reset',          to: 'password_resets#reset'
  end

  patch 'update_password',           to: 'password_resets#update_password'
  
  # Authentication in admin page
  get '/login',                     to: 'authentication#new'
  post '/login',                    to: 'authentication#create'
  delete '/logout',                 to: 'authentication#destroy'
  
  # Authenticate with facebook
  post '/authenticate',             to: 'authentication#authenticate'
  
  # Authentication api
  post '/sign_up',                  to: 'authentication#sign_up'
  post '/sign_in',                  to: 'authentication#sign_in'
  
  root 'authentication#new'

  resources :authentication,        only: %i[authenticate new destroy sign_up]
  resources :users,                 only: %i[update_question index show available] 
  resources :password_resets,       only: %i[new edit]
end