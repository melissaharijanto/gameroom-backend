class RemoveCommentsFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :comments, :integer
  end
end
