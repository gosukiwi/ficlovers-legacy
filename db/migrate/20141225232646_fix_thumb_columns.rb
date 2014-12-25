class FixThumbColumns < ActiveRecord::Migration
  def change
    rename_column :stories, :thumb_temp_url, :thumb_url
    remove_column :stories, :thumb_path
  end
end
