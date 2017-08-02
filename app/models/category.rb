class Category < ApplicationRecord
  has_many :parent_links, class_name: 'CategoryHierarchy',
                          foreign_key: 'category2_id'
  has_many :parents, through: :parent_links, source: :category1,
                     class_name: 'Category'

  has_many :child_links, class_name: 'CategoryHierarchy',
                         foreign_key: 'category1_id'
  has_many :children, through: :child_links, source: :category2,
                      class_name: 'Category'
end
