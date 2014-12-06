class AddViewsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :views, :integer, default: 0
  end
end
