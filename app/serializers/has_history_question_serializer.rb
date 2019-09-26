class HasHistoryQuestionSerializer
  def initialize(question, user_question)
    @question = question
    @user_question = user_question
  end

  def serialize
    {
      id: @question.id,
      content: @question.content,
      latest_answer: @user_question.latest_answer,
      application: @user_question.application,
      answers: @user_question.answers.map { |a| AnswerSerializer.new(a) }
    }
  end
end