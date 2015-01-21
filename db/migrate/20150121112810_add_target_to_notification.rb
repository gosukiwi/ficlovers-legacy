class AddTargetToNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :action
    add_column :notifications, :target_id, :integer
    add_column :notifications, :target_type, :string
  end
end
