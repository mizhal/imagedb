class AddOrderToCategoryHierarchies < ActiveRecord::Migration[5.1]
  def change
    add_column :category_hierarchies, :order, :integer, default: -1
  end
end
