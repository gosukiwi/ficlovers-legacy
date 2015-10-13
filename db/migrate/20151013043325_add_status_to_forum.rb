class AddStatusToForum < ActiveRecord::Migration
  def change
    add_column :forums, :status, :integer, default: 0
  end
end
