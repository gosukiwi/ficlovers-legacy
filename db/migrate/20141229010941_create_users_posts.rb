class CreateUsersPosts < ActiveRecord::Migration
  def change
    create_table :users_posts do |t|
      t.integer :post_id
      t.integer :user_id
    end
    add_index :users_posts, [:post_id, :user_id], unique: true
  end
end
