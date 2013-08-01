class AddRootIdToTrees < ActiveRecord::Migration
  def change
    add_column :trees, :root_id, :integer
  end
end
