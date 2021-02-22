# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

_____________________________________________________________



## users テーブル

| Column                  | Type   | Options                  |
| ----------------------- | ------ | ------------------------ |
| email                   | string | null: false, unique: true|
| encrypted_password      | string | null: false              |
| nickname                | string | null: false, unique: true|
| last_name               | string | null: false              |
| first_name              | string | null: false              |
| last_name_kana          | string | null: false              |
| first_name_kana         | string | null: false              |
| self_introduction       | text   | null: false              |


### Association

- has_many :tweets
- has_many :likes


## tweets テーブル

| Column                 | Type          | Options           |
| ---------------------- | ------------- | ----------------- |
| text                   | text          |                   |
| user                   | references    | foreign_key: true |

### Association

- belongs_to :user
- has_many   :likes



## likes テーブル

| Column                 | Type          | Options           |
| -----------------------| ------------- | ----------------- |
| user                   | references    | foreign_key: true |
| tweet                  | references    | foreign_key: true |


### Association

- belongs_to :user
- belongs_to :tweet


