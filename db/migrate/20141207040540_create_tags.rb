class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :context, limit: 15, index: true

      t.timestamps
    end
  end
end
