RailsAdmin.config do |config|
  config.model "User" do
    show do
      exclude_fields :created_at, :updated_at, :password_digest, :is_admin
    end

    list do
      include_fields :uid, :name, :email
      exclude_fields :created_at, :updated_at, :password_digest, :is_admin
    end
  end
  
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
