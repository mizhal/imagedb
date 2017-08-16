require 'rails_helper'

RSpec.describe CategoryHierarchy, type: :model do
  it 'has hierarchy' do
    cat1 = create(:category, name: 'cat1')
    ok_toplevel = CategoryHierarchy.put_toplevel cat1
    expect(ok_toplevel).to be true
    cat11 = create(:category, name: 'cat11')
    cat12 = create(:category, name: 'cat12')
    cat111 = create(:category, name: 'cat111')

    CategoryHierarchy.add_child cat1, cat11
    CategoryHierarchy.add_child cat1, cat12
    CategoryHierarchy.add_child cat11, cat111

    expect(cat11.parents).to include cat1
    expect(cat111.parents).to include cat11

    expect(CategoryHierarchy.cat_ancestors(cat111)).to match_array [cat11, cat1]
    expect(CategoryHierarchy.siblings(cat11)).to match_array [cat11, cat12]
  end

  it 'does not allow duplicate names' do
    cat1 = create(:category, name: 'cat1')
    CategoryHierarchy.put_toplevel cat1
    cat2 = create(:category, name: 'cat2')
    CategoryHierarchy.put_toplevel cat2
    cat3 = create(:category, name: 'cat3')
    CategoryHierarchy.put_toplevel cat3
    cat4 = create(:category, name: 'cat2')
    CategoryHierarchy.put_toplevel cat4

    expect(cat4.errors.messages[:duplicate_name]).to match_array ['cat2']
  end
end