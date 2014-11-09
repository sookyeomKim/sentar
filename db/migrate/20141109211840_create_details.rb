class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :name
      t.integer :quantity
      t.references :option, index: true

      t.timestamps
    end
  end
end
