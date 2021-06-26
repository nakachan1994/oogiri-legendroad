FactoryBot.define do
  factory :answer do
    association :theme
    association :user
    content { Faker::Lorem.characters(number: 10) }
  end
end
