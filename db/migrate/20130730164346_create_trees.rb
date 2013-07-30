class CreateTrees < ActiveRecord::Migration
  def change
    create_table :trees do |t|
      t.integer :owner_id
      t.string :title

      t.timestamps
    end
    add_index :trees, :owner_id
  end
end
