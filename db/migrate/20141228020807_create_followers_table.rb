class CreateFollowersTable < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :follower_id
      t.integer :followee_id
    end
    add_index :followers, [:follower_id, :followee_id], unique: true
  end
end
