class AddIndexesToUsers < ActiveRecord::Migration
  def change
  	add_index :users, :id
    add_index :users, :password_reset_token
  end
end
