RailsAdmin.config do |config|
  config.actions do
    config.authorize_with :cancan
    config.parent_controller = 'ApplicationController'
    config.current_user_method(&:current_user)
    dashboard                     # mandatory
    index                         # mandatory
    show
    show_in_app
  end
end
