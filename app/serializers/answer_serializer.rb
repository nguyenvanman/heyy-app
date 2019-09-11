class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :answered_at
end
