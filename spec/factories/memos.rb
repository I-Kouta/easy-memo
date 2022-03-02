FactoryBot.define do
  factory :memo do
    title_history { Faker::Lorem.sentence }
    why_content   { Faker::Lorem.sentence }
    who_content   { Faker::Lorem.sentence }
    where_content { Faker::Lorem.sentence }
    content       { Faker::Lorem.sentence }
    association :user
  end
end
