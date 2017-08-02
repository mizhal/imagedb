class CategoryHierarchy < ApplicationRecord
  belongs_to :category1, class_name: 'Category'
  belongs_to :category2, class_name: 'Category'
end
