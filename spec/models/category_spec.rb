require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has hierarchy' do
    cat1 = create(:category)
    cat11 = create(:category)
    cat12 = create(:category)
    cat111 = create(:category)

    cat1.children << cat11
    cat1.children << cat12
    cat11.children << cat111

    expect(cat11.parents).to include cat1
    expect(cat111.parents).to include cat11

    expect(cat111.ancestors).to match_array [cat11, cat1]
  end
end
