class UserSerializer < ActiveModel::Serializer
  attributes :id, :uid, :name, :email
end
