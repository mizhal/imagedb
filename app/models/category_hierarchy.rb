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

  def has_category_as_child?(category)
    category2 == category
  end

  ### TREE MANAGEMENT
  def self.root_id
    Category.order('id asc').limit(1).pluck(:id).first
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
    return true if rel.persisted?
    rel.errors.each do |key, value|
      child.errors.add(key, value)
    end
    false
  end

  def self.first_child(category)
    CategoryHierarchy.where(category1: category1).limit(1)
                     .order('order asc')
                     .pluck(:id)
                     .first
  end

  def self.last_child_id(category)
    CategoryHierarchy.where(category1: category1).limit(1)
                     .order('order desc')
                     .pluck(:id)
                     .first
  end

  def self.move_parent(category, new_parent)
    parent_rels = CategoryHierarchy.where(category2: category)
    parent_rels.update_all(category1: new_parent)
  end

  def self.put_after(category, after_category)
    move_parent(category, after_category.parent)
    ref = after_category.order
    sibling_rels(category).select(:order).each do |node|
      if node.order > ref
        node.update_column(:order, node.order + 1)
      elsif node.has_category_as_child?(category)
        node.update_column(:order, ref + 1)
      end
    end
  end

  def self.put_before(category, before_category)
    move_parent(category, before_category.parent)
    ref = before_category.order
    sibling_rels(category).select(:order).each do |node|
      if node.order >= ref
        node.update_column(:order, node.order + 1)
      elsif node.has_category_as_child?(category)
        node.update_column(:order, ref)
      end
    end
  end

  def self.put_last(category)
    total = sibling_rels(category).count
    sibling_rels(category).select(:order).each do |node|
      if node.order > category.order
        node.update_column(:order, node.order - 1)
      elsif node.has_category_as_child?(category)
        node.update_column(:order, total)
      end
    end
  end

  def self.put_first(category)
    sibling_rels(category).select(:order).each do |node|
      if node.order < category.order
        node.update_column(:order, node.order + 1)
      elsif node.has_category_as_child?(category)
        node.update_column(:order, 0)
      end
    end
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
    sibling_rels(category).pluck(:category2_id)
  end

  def self.sibling_rels(category)
    parents = CategoryHierarchy.where(category2: category)
                               .pluck(:category1_id)
    CategoryHierarchy.where(category1_id: parents)
  end

  def self.siblings(category)
    Category.where(id: siblings_ids(category))
  end

  def self.previous_from(category)
    node = category.tree_node
    id = CategoryHierarchy.where('order < ?', node.order)
                          .order('order desc').pluck(:id).first
    Category.find(id) if id.present?
  end

  def self.next_from(category)
    node = category.tree_node
    id = CategoryHierarchy.where('order > ?', node.order)
                          .order('order asc').pluck(:id).first
    Category.find(id) if id.present?
  end
  ### END: TREE MANAGEMENT
end
