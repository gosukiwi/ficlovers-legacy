class AddForumIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :forum_id, :integer
    add_index :posts, :forum_id
  end
end
