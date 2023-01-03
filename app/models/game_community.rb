class GameCommunity < ApplicationRecord
    has_many :followings
    has_many :users, through: :followings

    validates :title, presence: true
    validates :image_url, presence: true
end
