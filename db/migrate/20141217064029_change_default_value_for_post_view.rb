class ChangeDefaultValueForPostView < ActiveRecord::Migration
  def change
    change_column :posts, :views, :integer, default: 0
  end
end
