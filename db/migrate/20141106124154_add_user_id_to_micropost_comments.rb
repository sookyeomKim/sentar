class AddUserIdToMicropostComments < ActiveRecord::Migration
  def change
    add_column :micropost_comments, :user_id, :integer
  end
end
