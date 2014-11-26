class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :user_id
      t.integer :category_id
      t.text :summary

      t.timestamps
    end
  end
end
