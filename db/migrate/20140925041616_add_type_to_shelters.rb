class AddTypeToShelters < ActiveRecord::Migration
  def change
    #rename_column :shelters, :type, :kind
    add_column :shelters, :kind, :string
    #add_index :shelters, :kind
  end
end
