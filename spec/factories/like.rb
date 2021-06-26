FactoryBot.define do
  factory :like do
    association :user
    association :answer
  end
end
