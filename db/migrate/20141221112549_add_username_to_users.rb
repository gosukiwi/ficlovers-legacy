class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, index: true, limit: 25
    remove_index :users, :email
  end
end
