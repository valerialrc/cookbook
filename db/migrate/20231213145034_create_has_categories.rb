class CreateHasCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :has_categories do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
