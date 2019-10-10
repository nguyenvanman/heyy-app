class SavedContentSerializer < ActiveModel::Serializer
  attributes :id, :content_type, :mhid, :name, :image
end
