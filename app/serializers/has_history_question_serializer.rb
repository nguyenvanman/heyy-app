class HasHistoryQuestionSerializer < ActiveModel::Serializer
    attributes :id, :content, :application

    has_many :answers, serializer: AnswerSerializer
end