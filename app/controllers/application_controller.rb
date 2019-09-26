class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :set_no_cache

    include AuthenticationHelper

    rescue_from ActionController::ParameterMissing, with: :missing_params
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

    def missing_params(e)
        render_error(e, :bad_request)
    end

    def record_not_found(e)
        render_error(e, :not_found)
    end

    def record_invalid(e)
        render_error(e, :bad_request)
    end

    def record_not_unique(e)
        render_error(e, :bad_request)
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

    def get_current_user
        @current_user = User.find(token_params[:id])
    end
end
