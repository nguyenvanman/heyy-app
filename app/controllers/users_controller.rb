class UsersController < ApplicationController
    before_action :logged_admin_user, only: [:index, :show]
    before_action :authorize_request, only: [:update_question]

    def index 
        @users = User.all
    end

    def update_question
        if (token_params[:id].nil? || params[:id].to_i != token_params[:id])
            render json: {
                message: :unauthorized,
                error: 'Invalid access token'
            }, status: :unauthorized
            return
        end

        user = User.find_by(id: params[:id])
        if user.nil?
            render json: { message: 'Failed', error: 'Invalid user id' }, status: :not_found
        else
            question = user.questions.find_or_initialize_by(question: params[:question])
            question.answer = params[:answer]
            if question.save
                render json: {
                    message: :ok,
                    question: QuestionSerializer.new(question)
                }, status: :ok
            else
                render json: {
                    message: :bad_request,
                    error: question.errors        
                }, status: :bad_request
            end
        end
    end

    def show 
        @user = User.includes(:questions).where(id: params[:id]).first
        render 'show'
    end
end
