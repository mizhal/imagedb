require 'rails_helper'

RSpec.describe "category_hierarchies/show", type: :view do
  before(:each) do
    @category_hierarchy = assign(:category_hierarchy, CategoryHierarchy.create!(
      :category1 => nil,
      :category2 => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
