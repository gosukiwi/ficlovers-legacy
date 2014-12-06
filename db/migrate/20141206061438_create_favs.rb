class CreateFavs < ActiveRecord::Migration
  def change
    create_table :favs do |t|
      t.integer :story_id
      t.integer :user_id
    end
    add_index :favs, [:user_id, :story_id], unique: true
  end
end
