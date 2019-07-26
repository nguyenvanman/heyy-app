class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    include AuthenticationHelper

    rescue_from CanCan::AccessDenied do |exception|
        log_out

        redirect_to main_app.root_url
    end

    def logged_admin_user
        if (!current_user&.is_admin)
            flash[:danger] = 'Please login by an admin account to continue' 
            redirect_to login_url
        end
    end

    def authorize_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode token
        rescue ActiveRecord::RecordNotFound => e
            render_failed(e.message, :unauthorized)
        rescue JWT::DecodeError => e
            render_failed(e.message, :unauthorized)
        end
    end
    
    def token_params
        @decoded
    end

        # render success response
    def render_success(output, status)
        render json: { message: status, data: output }, status: status
    end

    # render failed resource
    def render_failed(message, status)
        render json: { error: message }, status: status
    end
end
