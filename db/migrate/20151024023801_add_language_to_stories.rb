class AddLanguageToStories < ActiveRecord::Migration
  def change
    add_column :stories, :language, :integer
  end
end
