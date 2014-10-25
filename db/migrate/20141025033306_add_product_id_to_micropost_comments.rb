class AddProductIdToMicropostComments < ActiveRecord::Migration
  def change
    add_column :micropost_comments, :product_id, :integer
    add_index :micropost_comments, :product_id
  end
end
