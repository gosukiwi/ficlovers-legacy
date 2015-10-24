class AddLanguageToStories < ActiveRecord::Migration
  def change
    add_column :stories, :language, :integer, default: 0
    add_index :stories, :language
    add_index :stories, :views
  end
end
