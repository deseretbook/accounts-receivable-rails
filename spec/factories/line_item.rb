FactoryBot.define do
  factory :line_item do
    quantity { Faker::Number.within(range: 1..40) }
    description { Faker::Quote.yoda }
  end
end
