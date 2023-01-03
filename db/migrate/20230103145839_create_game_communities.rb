class CreateGameCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :game_communities do |t|
      t.string :title
      t.string :image_url
      t.integer :followers

      t.timestamps
    end
  end
end
