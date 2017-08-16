class CategoryHierarchy < ApplicationRecord
  belongs_to :category1, class_name: 'Category' # parent
  belongs_to :category2, class_name: 'Category' # child

  scope :top_level, -> { where(category1_id: CategoryHierarchy.root_id) }

  validate :unique_name

  def unique_name
    duplicate = category1.children.exists?(name: category2.name)
    errors.add(:duplicate_name, category2.name) if duplicate
  end

  def top_level?
    category1_id == CategoryHierarchy.root_id
  end

  def parent_rels
    CategoryHierarchy.where(category2_id: category1_id)
  end

  ### TREE MANAGEMENT
  def self.root_id
    Category.order('id asc').pluck(:id).first
  end

  def self.put_toplevel(category)
    last_order = CategoryHierarchy.top_level.count
    rel = CategoryHierarchy.create category1_id: CategoryHierarchy.root_id,
                                   category2: category,
                                   order: last_order + 1
    return true if rel.persisted?
    rel.errors.each do |key, value|
      category.errors.add(key, value)
    end
    false
  end

  def self.add_child(parent, child)
    last_order = CategoryHierarchy.where(category1:parent).count
    rel = CategoryHierarchy.create category1: parent, category2: child,
                                   order: last_order
    return true if rel.valid?
    rel.errors.each do |key, value|
      child.errors.add(key, value)
    end
    false
  end

  def self.cat_ancestors(category)
    Category.where(id: ancestor_ids(category))
  end

  def self.ancestor_ids(category)
    all = CategoryHierarchy.where(category2: category)
    res = []
    if all.any?
      itr = all.first
      until itr.top_level?
        res << itr.category1_id
        itr = itr.parent_rels.first
      end
    end
    res
  end

  def self.siblings_ids(category)
    parents = CategoryHierarchy.where(category2: category)
    CategoryHierarchy.where(category1_id: parents.collect(&:category1_id))
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
