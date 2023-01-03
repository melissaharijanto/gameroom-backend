class Following < ApplicationRecord
  belongs_to :user
  belongs_to :game_community

  validates :user_id, presence: true
  validates :game_community_id, presence: :true
end
