FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:5) }
    email {Faker::Internet.email}
    profile_image_id { Faker::Lorem.characters(number:10) }
    password { Faker::Lorem.characters(number:10) }
  end
end