class SavedContentSerializer < ActiveModel::Serializer
  attributes :id, :content_type, :content
end
