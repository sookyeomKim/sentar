class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :micropost_id

      t.timestamps
    end
  end
end
