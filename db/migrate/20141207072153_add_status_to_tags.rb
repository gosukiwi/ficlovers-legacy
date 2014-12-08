class AddStatusToTags < ActiveRecord::Migration
  def change
    add_column :tags, :status, :string, limit: 10, default: 'pending', index: true
  end
end
