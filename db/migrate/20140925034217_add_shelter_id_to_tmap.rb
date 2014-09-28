class AddShelterIdToTmap < ActiveRecord::Migration
  def change
  	add_column :shelters, :tmap_id, :integer
  end
end
