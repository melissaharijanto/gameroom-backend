class AddLikesToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :likes, :integer, array: true, default: []
  end
end
