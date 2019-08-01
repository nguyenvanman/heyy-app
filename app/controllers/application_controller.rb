class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :set_no_cache

    include AuthenticationHelper

    rescue_from CanCan::AccessDenied do |exception|
        log_out
        redirect_to main_app.root_url
    end

    def set_no_cache
        response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
        response.headers['Pragma'] = 'no-cache'
        response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
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
            render_error(e.message, :unauthorized)
        rescue JWT::DecodeError => e
            render_error(e.message, :unauthorized)
        rescue => e
            render_error('Invalid access token', :unauthorized)
        end
    end
    
    def token_params
        @decoded
    end

    def render_success(output, status)
        render json: { message: status, data: output }, status: status
    end

    def render_error(error, status)
        render json: { message: status, error: error }, status: status
    end
end
