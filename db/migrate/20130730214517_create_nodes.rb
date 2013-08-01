class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|

      t.integer :parent_id
      t.string :text

      t.timestamps
    end
  end
end
