class UsersController < ApplicationController
    before_action :logged_admin_user, only: %i[index show]
    before_action :authorize_request, only: %i[info]
    before_action :valid_user, only: %i[info]
    before_action :get_user, only: %i[info show]

    def index 
        @users = User.order(:id).all
    end

    def show 
        render 'show'
    end

    def info
        render json: { message: :ok, user: SampleUserSerializer.new(@user) }, status: :ok
    end

    def available
        params.require(:email)
        is_existed = User.find_by_email(params[:email]).present?
        render json: { message: :ok, is_available: !is_existed }, status: :ok
    end

    def get_user
        params.require(:id)
        @user = User.find(params[:id])
    end

    def valid_user
        if (token_params[:id].nil? || token_params[:id] != params[:id].to_i)
            render_error('Invalid access token or user id', :unauthorized)
        end
    end
end
