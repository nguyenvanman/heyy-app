class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    include AuthenticationHelper

    def logged_admin_user
        if (!current_user&.is_admin)
            flash[:danger] = 'Please login by an admin account to continue' 
            redirect_to login_url
        end
    end
end
