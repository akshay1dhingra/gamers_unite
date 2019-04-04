class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :score, :user_id, :game_id
  belongs_to :game
  belongs_to :user
end
