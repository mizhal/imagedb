class Category < ApplicationRecord
  has_many :parent_links, class_name: 'CategoryHierarchy',
                          foreign_key: 'category2_id'
  has_many :parents, through: :parent_links, source: :category1,
                     class_name: 'Category'

  has_many :child_links, class_name: 'CategoryHierarchy',
                         foreign_key: 'category1_id'
  has_many :children, through: :child_links, source: :category2,
                      class_name: 'Category'

  validates :name, presence: true

  ### CALLBACKS
  after_save :assign_order
  def assign_order
    if order.negative?
      last_item = siblings.select(:order).order("order desc").first
      if last_item.present?
        update_column(:order, last_item.order + 1)
      else
        update_column(:order, 0)
      end
    end
  end
  ### END: CALLBACKS

  scope :top_level, lambda {
    left_outer_joins(:parent_links)
      .where(category_hierarchies: { category2_id: nil })
  }

  scope :leafs, lambda {
    left_outer_joins(:child_links)
      .where(category_hierarchies: { category1_id: nil })
  }

  ## category siblings including self
  def siblings
    if top_level?
      Category.top_level
    else
      Category.joins(:parent_links)
              .where(category_hierarchies: {
                      category1_id: parents
                    })
    end
  end

  def top_level?
    parent_links.empty?
  end

  def leaf?
    child_links.empty?
  end

  ## main hierarchical ancestry: first parent
  def ancestors
    itr = self
    res = []
    until itr.top_level?
      itr = itr.parents.first
      res << itr
    end
    res
  end

  def add_child(category)
    rel = CategoryHierarchy.create category1: self, category2: category
    if rel.valid?
      true
    else
      category.errors.add(:duplicate_name, category.name)
      false
    end
  end

  ## Categories are sorted in each level, previous category is
  ## the one with the previous order number
  def previous
  end

  def next 
  end
end
