class AddPostToStories < ActiveRecord::Migration
  def change
    add_column :stories, :post_id, :integer, index: true
  end
end
