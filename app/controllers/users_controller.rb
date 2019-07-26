class UsersController < ApplicationController
    before_action :logged_admin_user, only: [:index]
    before_action :authorize_request, only: [:update_question]

    def index 
        @users = User.all
    end

    def update_question
        user = User.find_by(id: params[:id], uid: token_params[:uid])
        if user.nil?
            render json: { message: 'Failed', error: 'Invalid user id' }, status: :not_found
        else
            question = user.questions.find_or_initialize_by(question: params[:question])
            question.answer = params[:answer]
            if question.save
                render json: {
                    message: 'Updated question',
                    question: question
                }, status: :ok
            else
                render json: {
                    message: 'Failed to update question',
                    error: question.errors        
                }
            end
        end
    end
end
