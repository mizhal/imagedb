require 'rails_helper'

RSpec.describe Category, type: :model do
  xit 'mantains order' do
    cat1 = create(:category, name: 'cat1', order: 1)
    cat2 = create(:category, name: 'cat2', order: 2)
    cat3 = create(:category, name: 'cat3', order: 3)

    cat4 = create(:category, name: 'cat4')

    expect(cat4.order).to eq(4)

  end
end
