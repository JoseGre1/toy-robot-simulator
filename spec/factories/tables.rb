FactoryBot.define do
  factory :table do
    side = Faker::Number.between(5, 100)
    size_x side
    size_y side
  end
end
