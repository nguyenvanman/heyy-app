class UsersController < ApplicationController
    before_action :logged_admin_user, only: [:index, :show]
    before_action :authorize_request, only: [:update_question, :info]

    def index 
        @users = User.all
    end

    def update_question
        if (token_params[:id].nil?)
            render json: { message: :unauthorized, error: 'Invalid access token' }, status: :unauthorized
            return
        end
        user = User.find_by(id: token_params[:id])
        if user.nil?
            render json: { message: 'Failed', error: 'Invalid user id' }, status: :not_found
        else
            question = user.questions.find_or_initialize_by(question: params[:question])
            question.answer = params[:answer]
            if question.save
                render json: { message: :ok, question: QuestionSerializer.new(question) }, status: :ok
            else
                render json: { message: :bad_request, error: question.errors }, status: :bad_request
            end
        end
    end

    def info
        if (token_params[:id].nil? || token_params[:id] != params[:id].to_i)
            render json: { message: :unauthorized, error: 'Invalid access token or user id' }, status: :unauthorized
        else 
            user = User.includes(:questions).find(params[:id])
            render json: {
                message: :ok,
                user: SampleUserSerializer.new(user)
            }, status: :ok
        end
    rescue ActiveRecord::RecordNotFound => e
        render json: { message: :not_found, error: e.message }, status: :not_found
    end

    def show 
        @user = User.includes(:questions).where(id: params[:id]).first
        render 'show'
    end
end
