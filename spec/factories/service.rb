FactoryBot.define do
  factory :service do
    name { Faker::Name.name }
    price_cents { Faker::Number.number(digits: 4) }
  end
end
