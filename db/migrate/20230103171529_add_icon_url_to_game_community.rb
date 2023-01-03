class AddIconUrlToGameCommunity < ActiveRecord::Migration[7.0]
  def change
    add_column :game_communities, :icon_url, :string
  end
end
