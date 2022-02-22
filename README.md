# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association
- has_many :memos

## memos テーブル

| Column        | Type        | Options                        |
| ------------- | ----------- | ------------------------------ |
| title_history | text        | null: false                    |
| why_content   | text        | null: false                    |
| who_content   | text        | null: false                    |
| what_content  | text        | null: false                    |
| where_content | text        | null: false                    |
| content       | text        | null: false                    |
| user          | references  | null: false, foreign_key: true |

### Association
- belongs_to :user