class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.belongs_to :tag
      t.belongs_to :story
    end
  end
end
