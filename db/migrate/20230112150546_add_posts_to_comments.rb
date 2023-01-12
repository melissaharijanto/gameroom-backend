class AddPostsToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :posts, :integer, array: true, default: []
  end
end
