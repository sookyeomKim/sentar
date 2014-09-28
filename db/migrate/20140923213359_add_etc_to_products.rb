class AddEtcToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :picture2, :string
  	add_column :products, :picture3, :string
  	add_column :products, :content, :text
  end
end
