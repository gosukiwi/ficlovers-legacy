class AddDeletedByToPrivateMessages < ActiveRecord::Migration
  def change
    add_column :private_messages, :deleted_by, :integer, default: 0
    add_index :private_messages, :deleted_by
  end
end
