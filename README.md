# データベース設計

## usersテーブル（ユーザー管理機能）

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birth_date         | date   | null: false               |

### Association
- has_many :item
- has_many :buy

## itemsテーブル（商品出品機能）

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| product_name         | string     | null: false                    |
| product_description  | text       | null: false                    |
| product_category_id  | integer    | null: false                    |
| product_condition_id | integer    | null: false                    |
| shipping_charge_id   | integer    | null: false                    |
| region_of_origin_id  | integer    | null: false                    |
| shipping_day_id      | integer    | null: false                    |
| selling_price        | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :buy
- has_one_attached :image (ActiveStorageで実装)

## buysテーブル（購入履歴機能）

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addressesテーブル（商品購入機能）

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| post_code       | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| municipality    | string     | null: false                    |
| street_address  | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | string     | null: false                    |
| buy             | references | null: false, foreign_key: true |

### Association
- belongs_to :buy