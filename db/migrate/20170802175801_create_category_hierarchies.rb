class CreateCategoryHierarchies < ActiveRecord::Migration[5.1]
  def change
    create_table :category_hierarchies do |t|
      t.belongs_to :category1, foreign_key: { to_table: :categories }
      t.belongs_to :category2, foreign_key: { to_table: :categories }

      t.timestamps
    end
  end
end
