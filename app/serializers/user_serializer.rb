class UserSerializer < ActiveModel::Serializer
  attributes :uid, :name, :email
end
