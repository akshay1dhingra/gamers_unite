class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game

    validates :title, presence: true
    validates :content, presence: true
    validates :score, presence: true

    scope :descending_order, -> { order(score: :desc) }
    
    # def self.descending_order
    #     order('created_at desc')
    # end

end
