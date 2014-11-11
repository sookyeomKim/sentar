class AddOptionsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :option, :string
    add_column :purchases, :detail, :string
  end
end
