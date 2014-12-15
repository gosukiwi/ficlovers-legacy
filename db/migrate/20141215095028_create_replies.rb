class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :post_id, index: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
