class ReviseCommentsMigration < ActiveRecord::Migration
  def change
  	remove_column :comments, :post_id
  	add_column :comments, :micropost_id, :integer
  	add_column :comments, :user_name, :string
  end
end
