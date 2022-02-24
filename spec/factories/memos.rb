FactoryBot.define do
  factory :memo do
    title_history              { Faker::Name.initials(number: 2) }
    why_content              { Faker::Name.initials(number: 2) }
    who_content              { Faker::Name.initials(number: 2) }
    where_content              { Faker::Name.initials(number: 2) }
    content              { Faker::Name.initials(number: 2) }
    association :user
  end
end
