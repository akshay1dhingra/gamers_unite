class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game

    validates :title, presence: true
    validates :content, presence: true
    validates :score, presence: true

    scope :score, -> (number) { where ("score < ?"), number }
end
