class AddCommentsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments, :integer, array: true, default: [] 
  end
end
