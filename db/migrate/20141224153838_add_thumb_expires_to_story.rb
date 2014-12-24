class AddThumbExpiresToStory < ActiveRecord::Migration
  def change
    add_column :stories, :thumb_expiration, :datetime
  end
end
