class AddLanguageToStories < ActiveRecord::Migration
  def change
    add_column :stories, :language, :integer, default: 0
  end
end
