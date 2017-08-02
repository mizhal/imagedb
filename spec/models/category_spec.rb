require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has hierarchy' do
    cat1 = build(:category)
    cat11 = build(:category)
    cat12 = build(:category)
    cat111 = build(:category)

    cat1.children << cat11
  end
end
