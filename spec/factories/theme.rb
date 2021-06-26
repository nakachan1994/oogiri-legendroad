FactoryBot.define do
  factory :theme do
    association :user
    content { Faker::Lorem.characters(number: 10) }
  end
end
