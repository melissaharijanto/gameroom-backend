class User < ApplicationRecord
    has_many :game_communities, through: :followings

    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
end
