class AddIndexToTaxonomies < ActiveRecord::Migration
  def change
    add_index :taxonomies, [:story_id, :tag_id], unique: true
  end
end
