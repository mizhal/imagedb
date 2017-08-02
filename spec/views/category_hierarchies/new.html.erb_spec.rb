require 'rails_helper'

RSpec.describe "category_hierarchies/new", type: :view do
  before(:each) do
    assign(:category_hierarchy, CategoryHierarchy.new(
      :category1 => nil,
      :category2 => nil
    ))
  end

  it "renders new category_hierarchy form" do
    render

    assert_select "form[action=?][method=?]", category_hierarchies_path, "post" do

      assert_select "input[name=?]", "category_hierarchy[category1_id]"

      assert_select "input[name=?]", "category_hierarchy[category2_id]"
    end
  end
end
