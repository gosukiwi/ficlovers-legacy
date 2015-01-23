class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.integer :author_id
      t.integer :receiver_id
      t.text :message

      t.timestamps
    end
  end
end
