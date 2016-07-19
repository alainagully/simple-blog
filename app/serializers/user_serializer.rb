class UserSerializer < ActiveModel::Serializer
  attributes :first_name

  has_many :posts
end
