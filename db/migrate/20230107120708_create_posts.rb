class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.string :username
      t.integer :likes
      t.integer :comments

      t.timestamps
    end
  end
end
