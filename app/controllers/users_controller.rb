class UsersController < ApplicationController
    before_action :logged_admin_user, only: %i[index show]
    before_action :authorize_request, only: %i[update_question info question_history]
    before_action :valid_user, only: %i[info]
    before_action :get_user, only: %i[info show]
    before_action :get_user_from_token, only: %i[update_question question_history]

    def index 
        @users = User.order(:id).all
    end

    def show 
        render 'show'
    end

    def update_question
        @question = @user.questions.find_or_initialize_by(question: question_params[:question])
        @question.application = question_params[:application]
        if @question.save
            @question.answers.create(answer: question_params[:answer])
            render json: { message: :ok, question: QuestionSerializer.new(@question) }, status: :ok
        else
            render_error(question.errors, :bad_request)
        end
    end

    def question_history
        @question = @user.questions.find(question_id)
        render json: { message: :ok, question: HasHistoryQuestionSerializer.new(@question) }
    end

    def info
        render json: { message: :ok, user: SampleUserSerializer.new(@user) }, status: :ok
    end

    def available
        params.require(:email)
        is_existed = User.find_by_email(params[:email]).present?
        render json: { message: :ok, is_available: !is_existed }, status: :ok
    end

    def question_id
        params.require(:question_id)
        params[:question_id].to_i
    end

    def question_params
        params.require(:application)
        params.require(:question)
        params.require(:answer)
        params.permit(:question, :answer, :application)
    end

    def get_user
        params.require(:id)
        @user = User.find(params[:id])
    end

    def get_user_from_token
        @user = User.find(token_params[:id])
    end

    def valid_user
        if (token_params[:id].nil? || token_params[:id] != params[:id].to_i)
            render_error('Invalid access token or user id', :unauthorized)
        end
    end
end
