class RemoveFollowersTable < ActiveRecord::Migration
  def change
    drop_table :followers
  end
end
