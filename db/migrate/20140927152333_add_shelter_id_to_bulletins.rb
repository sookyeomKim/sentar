class AddShelterIdToBulletins < ActiveRecord::Migration
  def change
  	add_column :bulletins, :shelter_id, :integer
  	add_index :bulletins, :shelter_id
  end
end
