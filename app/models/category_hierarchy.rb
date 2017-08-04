class CategoryHierarchy < ApplicationRecord
  belongs_to :category1, class_name: 'Category'
  belongs_to :category2, class_name: 'Category'

  validate :unique_hierarchical_name
  def unique_hierarchical_name
    if category1.children.collect(&:name).include?(category2.name)
      errors.add(:duplicate_name, category2.name) 
    end
  end
end
