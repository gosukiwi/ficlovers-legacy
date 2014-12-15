class RenameForumCategoriesToForums < ActiveRecord::Migration
  def change
    rename_table :forum_categories, :forums
  end
end
