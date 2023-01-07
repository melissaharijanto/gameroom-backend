class DropFollowings < ActiveRecord::Migration[7.0]
  def change
    drop_table :followings
  end
end
