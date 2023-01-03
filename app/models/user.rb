class User < ApplicationRecord
    has_many :game_communities, through: :followings
    # /\A^(?=.{8,20}$)(?![_.])[a-zA-Z0-9._]+(?<![_.])$\z/
    has_secure_password
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates_format_of :username, :with => /\A^(?=.{3,30}$)(?![_.])[a-zA-Z0-9._]+(?<![_.])$\z/, :message => "must be 3 to 30 characters long and cannot start or end with _ or ."
    validates :password, presence: true
    validates_length_of :password, :minimum => 6, :message => "must be at least 6 characters long."
end
