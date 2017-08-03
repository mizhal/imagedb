FactoryGirl.define do
  factory :category do
    name { "Cat #{Faker::Lorem.word}" }
    system false
  end
end