class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :reviews
  belongs_to :users, through: :reviews
end
