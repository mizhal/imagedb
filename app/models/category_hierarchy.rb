class CategoryHierarchy < ApplicationRecord
  VIRTUAL_ROOT_ID = 0

  belongs_to :category1, class_name: 'Category'
  belongs_to :category2, class_name: 'Category'

  scope :top_level, -> { where(category1_id: VIRTUAL_ROOT_ID) }

  validate :unique_name

  def unique_name
    duplicate = top_level? && Category.top_level.exists?(name: category2.name)
    duplicate ||= !top_level? && category1.children.exists?(name: category2.name)
    errors.add(:duplicate_name, category2.name) if duplicate
    duplicate
  end

  def top_level?
    category1_id == VIRTUAL_ROOT_ID
  end

  def parent_rels
    Category.where(category2_id: category1_id)
  end

  ### TREE MANAGEMENT

  def self.put_toplevel(category)
    last_order = CategoryHierarchy.top_level.count
    rel = CategoryHierarchy.create category1_id: VIRTUAL_ROOT_ID,
                                   category2: category,
                                   order: last_order + 1
    return true if rel.valid?
    rel.errors.each do |err|
      category.errors << err
    end
    false
  end

  def self.add_child(parent, child)
    last_order = CategoryHierarchy.where(category1:parent).count
    rel = CategoryHierarchy.create category1: parent, category2: child,
                                   order: last_order
    return true if rel.valid?
    rel.errors.each do |err|
      child.errors << err
    end
    false
  end

  def self.ancestors(category)
    Category.where(id: ancestor_ids(category))
  end

  def self.ancestor_ids(category)
    itr = CategoryHierarchy.where(category2: category)
    res = []
    until itr.top_level?
      res << itr.category1_id
      itr = itr.parent_rels.first
    end
    res
  end

  def self.siblings_ids(category)
    parents = CategoryHierarchy.where(category2: category)
    CategoryHierarchy.where(category1: parents)
                     .pluck(:category2_id)
  end

  def self.siblings(category)
    Category.where(id: siblings_ids(category))
  end

  def self.previous_from(category)
    
  end

  def self.next_from(category)
    
  end
  ### END: TREE MANAGEMENT
end
