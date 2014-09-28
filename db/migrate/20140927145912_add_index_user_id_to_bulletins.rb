class AddIndexUserIdToBulletins < ActiveRecord::Migration
  def change
  	add_column :bulletins, :user_id, :integer
  	add_index :bulletins, :user_id
  end
end
