require 'rails_helper'

RSpec.describe "category_hierarchies/index", type: :view do
  before(:each) do
    assign(:category_hierarchies, [
      CategoryHierarchy.create!(
        :category1 => nil,
        :category2 => nil
      ),
      CategoryHierarchy.create!(
        :category1 => nil,
        :category2 => nil
      )
    ])
  end

  it "renders a list of category_hierarchies" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
