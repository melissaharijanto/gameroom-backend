class User < ApplicationRecord
    has_many :game_communities, through: :followings
    
    has_secure_password

    validates :username, presence: true, uniqueness: { case_sensitive: false }
    # Regex modified from https://stackoverflow.com/questions/12018245/regular-expression-to-validate-username
    validates_format_of :username, :with => /\A^(?=.{3,30}$)(?![_.])[a-zA-Z0-9._]+(?<![_.])$\z/, :message => "must be 3 to 30 characters long and cannot start or end with _ or ."
    validates :password, presence: true
    validates_length_of :password, :minimum => 6, :message => "must be at least 6 characters long."
end
