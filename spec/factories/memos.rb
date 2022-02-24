FactoryBot.define do
  factory :memo do
    title_history              { 'タイトル' }
    why_content              { 'なぜ書こうと思ったのか' }
    who_content              { '誰をみてその話をひらめいたのか' }
    where_content              { 'どこでその話を使うか' }
    content { '具体的な内容' }
    association :user
  end
end
