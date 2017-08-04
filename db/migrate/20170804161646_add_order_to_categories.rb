class AddOrderToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :order, :integer, default: 0
  end
end
