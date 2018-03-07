FactoryBot.define do
  factory :robot do
    association :table, factory: :table, strategy: :build
    pos_x { rand(0..table.size_x - 1) }
    pos_y { rand(0..table.size_y - 1) }
    direction %w[N E S W][Faker::Number.between(0, 3)]

    trait :unplaced do
      pos_x nil
      pos_y nil
      direction nil
    end
  end
end
