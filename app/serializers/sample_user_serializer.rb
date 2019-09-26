class SampleUserSerializer < ActiveModel::Serializer
  attributes :name, :email, :image_url, :questions
  # has_many :questions, serializer: QuestionSerializer
end
