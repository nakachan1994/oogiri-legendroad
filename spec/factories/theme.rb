FactoryBot.define do
  factory :theme do
    user_id
    content { Faker::Lorem.characters(number:10) }
    image_id { Faker::Lorem.characters(number:10) }
  end
end