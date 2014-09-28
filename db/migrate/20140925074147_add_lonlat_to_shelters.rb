class AddLonlatToShelters < ActiveRecord::Migration
  def change
  	add_column :shelters, :lonlat, :string
 
  end
end
