class AddPublishedToStories < ActiveRecord::Migration
  def change
    add_column :stories, :published, :boolean, default: false
    add_index :stories, :published
  end
end
