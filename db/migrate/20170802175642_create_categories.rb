class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :system
      t.boolean :hidden

      t.timestamps
    end
  end
end
