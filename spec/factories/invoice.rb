FactoryBot.define do
  factory :invoice do
    client
    net_days { 30 }
    note { Faker::Config.random }
  end
end
