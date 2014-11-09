class AddSellCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sell_count, :integer
  end
end
