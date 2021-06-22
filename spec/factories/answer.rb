FactoryBot.define do
  factory :answer do
    user_id
    theme_id
    content { Faker::Lorem.characters(number:10) }
  end
end