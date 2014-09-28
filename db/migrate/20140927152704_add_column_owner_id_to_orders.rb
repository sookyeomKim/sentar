class AddColumnOwnerIdToOrders < ActiveRecord::Migration
  def change
  	add_column :purchases , :owener_id , :integer
  end
end
