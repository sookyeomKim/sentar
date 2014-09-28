class CreateTmaps < ActiveRecord::Migration
  def change
    create_table :tmaps do |t|

      t.timestamps
    end
  end
end
