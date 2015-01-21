class CreateWallMessages < ActiveRecord::Migration
  def change
    create_table :wall_messages do |t|
      t.integer :author_id
      t.integer :receiver_id
      t.text :content

      t.timestamps
    end
  end
end
