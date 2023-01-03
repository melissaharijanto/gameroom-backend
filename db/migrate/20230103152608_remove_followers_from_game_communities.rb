class RemoveFollowersFromGameCommunities < ActiveRecord::Migration[7.0]
  def change
    remove_column :game_communities, :followers, :integer
  end
end
