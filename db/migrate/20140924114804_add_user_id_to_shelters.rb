class AddUserIdToShelters < ActiveRecord::Migration
  def change
    add_column :shelters, :user_id, :integer
    add_index :shelters, :user_id
  end
end
