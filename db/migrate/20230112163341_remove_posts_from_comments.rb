class RemovePostsFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :posts, :integer
  end
end
