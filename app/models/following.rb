class Following < ApplicationRecord
  belongs_to :user
  belongs_to :game_community
end
