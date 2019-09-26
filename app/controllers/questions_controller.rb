class QuestionsController < ApplicationController
  before_action :authorize_request, :get_current_user

  def update 
    question = Question.find_or_create_by!(content: question_params[:question])
    user_question = @current_user.user_questions.find_or_create_by!(question: question)
    user_question.answers.create!(content: question_params[:answer])
    user_question.update_attributes!(latest_answer: question_params[:answer], application: 'HeyWatch')
    render json: { message: :ok, question: QuestionSerializer.new(question, user_question).call }
  end
  
  def question_params
    params.require([:question, :answer])
    params.permit(:question, :answer)
  end
end
