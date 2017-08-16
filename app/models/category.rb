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

  scope :top_level, lambda {
    left_outer_joins(:parent_links)
      .where(category_hierarchies: { category2_id: CategoryHierarchy::ROOT_ID })
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
    parent_links.where.not(category2_id: CategoryHierarchy::VIRTUAL_ROOT_ID).empty?
  end

  def leaf?
    child_links.empty?
  end
end
