class QuestionSerializer
  def initialize(question, user_question)
    @question = question
    @user_question = user_question
  end

  def serialize
    {
      id: @question.id,
      question: @question.content,
      answer: @user_question.latest_answer,
      application: @user_question.application
    }
  end
end
