class ChangeThumbUrlToThumbTempUrl < ActiveRecord::Migration
  def change
    rename_column :stories, :thumb_url, :thumb_temp_url
  end
end
