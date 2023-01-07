class AddFollowersToGameCommunity < ActiveRecord::Migration[7.0]
  def change
    add_column :game_communities, :followers, :integer, array: true, default: []
  end
end
