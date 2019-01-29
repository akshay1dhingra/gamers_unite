class Game < ApplicationRecord
    has_many :reviews
    has_many :users, through: :reviews

    validates :name, :description, presence: true
    validates :name, :uniqueness => {:case_sensitive => false}
end
