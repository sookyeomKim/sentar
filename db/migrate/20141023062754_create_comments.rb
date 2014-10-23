class CreateComments < ActiveRecord::Migration
  def change
    create_table :micropost_comments do |t|
      t.string :user_name
      t.text :content
      t.integer :micropost_id

      t.timestamps
    end
  end
end
