class AddThumbToStories < ActiveRecord::Migration
  def change
    add_column :stories, :thumb_url, :string
  end
end
