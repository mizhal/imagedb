require 'rails_helper'

RSpec.describe "category_hierarchies/edit", type: :view do
  before(:each) do
    @category_hierarchy = assign(:category_hierarchy, CategoryHierarchy.create!(
      :category1 => nil,
      :category2 => nil
    ))
  end

  it "renders the edit category_hierarchy form" do
    render

    assert_select "form[action=?][method=?]", category_hierarchy_path(@category_hierarchy), "post" do

      assert_select "input[name=?]", "category_hierarchy[category1_id]"

      assert_select "input[name=?]", "category_hierarchy[category2_id]"
    end
  end
end
