class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    include AuthenticationHelper

    rescue_from CanCan::AccessDenied do |exception|
        log_out

        redirect_to main_app.root_url
    end
end
