class CreateForumCategories < ActiveRecord::Migration
  def change
    create_table :forum_categories do |t|
      t.string :name
      t.integer :parent_id, index: true

      t.timestamps
    end
  end
end
