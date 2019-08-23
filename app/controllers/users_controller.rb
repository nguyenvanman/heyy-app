class UsersController < ApplicationController
    before_action :logged_admin_user, only: [:index, :show]
    before_action :authorize_request, only: [:update_question, :info]

    def index 
        @users = User.all
    end

    def update_question
        if (token_params[:id].nil?)
            render_error('Invalid access token', :unauthorized)
            return
        end
        user = User.find_by(id: token_params[:id])
        if user.nil?
            render_error('Invalid user id', :not_found)
        else
            question = user.questions.find_or_initialize_by(question: params[:question])
            question.answer = params[:answer]
            question.application = params[:application]
            if question.save
                render json: { message: :ok, question: QuestionSerializer.new(question) }, status: :ok
            else
                render_error(question.errors, :bad_request)
            end
        end
    end

    def info
        if (token_params[:id].nil? || token_params[:id] != params[:id].to_i)
            render_error('Invalid access token or user id', :unauthorized)
        else 
            user = User.includes(:questions).find(params[:id])
            render json: { message: :ok, user: SampleUserSerializer.new(user) }, status: :ok
        end
    rescue ActiveRecord::RecordNotFound => e
        render_error(e.message, :bad_request)
    end

    def available
        if params[:email].nil?
            render_error('Missing email address', :bad_request) and return
        end 
        is_existed = User.find_by_email(params[:email]).present?
        render json: { message: :ok, is_available: !is_existed }, status: :ok
    end

    def show 
        @user = User.includes(:questions).where(id: params[:id]).first
        render 'show'
    end
end
