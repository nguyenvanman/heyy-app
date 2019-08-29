class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer, :application
end
