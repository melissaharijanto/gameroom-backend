class AddPostsToGameCommunity < ActiveRecord::Migration[7.0]
  def change
    add_column :game_communities, :posts, :integer, array: true, default: []
  end
end
