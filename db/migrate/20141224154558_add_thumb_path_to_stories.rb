class AddThumbPathToStories < ActiveRecord::Migration
  def change
    add_column :stories, :thumb_path, :string
  end
end
