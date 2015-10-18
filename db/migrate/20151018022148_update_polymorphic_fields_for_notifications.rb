class UpdatePolymorphicFieldsForNotifications < ActiveRecord::Migration
  def change
    rename_column :notifications, :target_id, :notificable_id
    rename_column :notifications, :target_type, :notificable_type
  end
end
