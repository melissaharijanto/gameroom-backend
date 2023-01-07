class AddGameCommunitiesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :game_community, null: false, foreign_key: true
  end
end
