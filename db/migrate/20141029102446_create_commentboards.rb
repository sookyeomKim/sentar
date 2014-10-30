class CreateCommentboards < ActiveRecord::Migration
  def change
    create_table :commentboards do |t|
      t.references :post, index: true
      t.text :body

      t.timestamps
    end
  end
end
