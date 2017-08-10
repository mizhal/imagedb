require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has hierarchy' do
    cat1 = create(:category, name: "cat1")
    cat11 = create(:category, name: "cat11")
    cat12 = create(:category, name: "cat12")
    cat111 = create(:category, name: "cat111")

    cat1.children << cat11
    cat1.children << cat12
    cat11.children << cat111

    expect(cat11.parents).to include cat1
    expect(cat111.parents).to include cat11

    expect(cat111.ancestors).to match_array [cat11, cat1]

    puts cat11.siblings.to_sql
    expect(cat11.siblings).to match_array [cat11, cat12]
  end

  it 'does not allow duplicates on toplevel' do
    cat1 = create(:category, name: 'cat1')
    cat2 = create(:category, name: 'cat2')
    cat3 = create(:category, name: 'cat3')
    cat4 = build(:category, name: 'cat2')

    cat4.save

    expect(cat4.persisted?).to be(false)
  end

  it 'does not allow duplicates on children' do
    cat1 = create(:category)
    cat11 = create(:category, name: 'cat11')
    cat12 = create(:category, name: 'cat11')
    cat13 = create(:category, name: 'cat13')

    expect(cat1.add_child(cat11)).to be(true)
    cat1.reload
    expect(cat1.add_child(cat12)).to be(false)
    expect(cat12.errors.messages[:duplicate_name]).to match_array ['cat11']

    cat1.reload
    expect(cat1.add_child(cat13)).to be(true)
  end

  it 'mantains order' do
    cat1 = create(:category, name: 'cat1', order: 1)
    cat2 = create(:category, name: 'cat2', order: 2)
    cat3 = create(:category, name: 'cat3', order: 3)

    cat4 = create(:category, name: 'cat4')

    expect(cat4.order).to eq(4)

  end
end
