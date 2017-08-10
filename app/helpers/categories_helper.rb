module CategoriesHelper
  def indent padding
    ('&nbsp;' * padding * 4 ).html_safe
  end
end
