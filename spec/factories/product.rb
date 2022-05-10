FactoryBot.define do
  factory :product do
    name { Faker::Hacker.adjective }
    price_cents { Faker::Number.number(digits: 4) }
  end
end
