class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :message
      t.boolean :read
      t.integer :user_id, index: true
      t.string :action

      t.timestamps
    end
  end
end
