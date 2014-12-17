class AddPostCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_count, :integer, default: 0
  end
end
