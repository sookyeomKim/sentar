class AddIndexToLikes < ActiveRecord::Migration
  def change
  	add_index :likes, :user_id
  	add_index :likes, :micropost_id

  end
end
