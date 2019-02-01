class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game

    validates :title, presence: true
    validates :content, presence: true
    validates :score, presence: true

    scope :descending_order, -> { order(score: :desc) }
    scope :select_score,  -> (review_score) { where("score > ?", review_score) }
    
end
