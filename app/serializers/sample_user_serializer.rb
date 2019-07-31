class SampleUserSerializer < ActiveModel::Serializer
  attributes :name, :email, :image_url
  has_many :questions, serializer: QuestionSerializer
end
