class HasHistoryQuestionSerializer < ActiveModel::Serializer
    attributes :id, :question, :application

    has_many :answers, serializer: AnswerSerializer
end