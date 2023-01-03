class GameCommunity < ApplicationRecord
    has_many :followings
    has_many :users, through: :followings

    validates :title, presence: true, uniqueness: { case_sensitive: false }
    validates :image_url, presence: true
    validates :icon_url, presence: true
end
