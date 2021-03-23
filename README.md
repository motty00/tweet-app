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

_____________________________________________________________________________________________________________________________________________

## アプリケーション名
* Tweet-App

## アプリケーション概要
* このアプリに登録したユーザーは日頃起こった出来事を発信でき、自分も含め他のユーザーは投稿に対しコメントをすることでコミュニケーションをとることができます。
  また、気に入った投稿があればその投稿とお気に入りに登録し一覧で確認することもできます。

## URL
https://tweet-app-34467.herokuapp.com/

## テスト用アカウント
### Basic認証
* ユーザー名：admin
* パスワード：2222
### テストユーザー１
* email :hoge@co.com
* pass  :hoge11
### テストユーザー２
* email :hogehoge@co.com
* pass  :hoge11

## 利用方法
* ユーザー登録を行うことでテキストの投稿、または画像の投稿をすることができます。
* 投稿された内容の詳細ページに進むことで、その投稿に対しコメントをすることができます。
* 投稿の一覧からハートマークのボタンをクリックすることでハートマークの色が変化し、お気に入りに登録することができます。
* サイドバーにあるお気に入りをクリックすると、自分が登録したお気に入りの投稿を一覧で表示することができます。
* 他ユーザーの詳細ページに行くことでフォローすることができフォロー一覧ページにフォローしたユーザー名が表示されます。
* 他ユーザーからフォローされるとフォロワー一覧ページにフォローしてくれたユーザー名が表示されます。

## 機能一覧
* ユーザー登録、ログイン機能(devise)
* テキスト、画像の投稿機能(Ajax)
* 投稿の編集、削除機能
* コメント機能
* お気に入り機能(Ajax)
* フォロー機能

## 実装予定の機能
* チャットルームを作りチャットルームのパスワードを知っている人同士でコミュニケーションができる機能

## データベース設計
* https://gyazo.com/61e9aa05f04c8b69bcdf67f98ab0da2c


_____________________________________________________________________________________________________________________________________________



## users テーブル

| Column                  | Type   | Options                  |
| ----------------------- | ------ | ------------------------ |
| email                   | string | null: false, unique: true|
| encrypted_password      | string | null: false              |
| nickname                | string | null: false              |
| last_name               | string | null: false              |
| first_name              | string | null: false              |
| last_name_kana          | string | null: false              |
| first_name_kana         | string | null: false              |
| self_introduction       | text   | null: false              |


### Association

- has_many :tweets
- has_many :likes
- has_many :comments
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user



## tweets テーブル

| Column                 | Type          | Options           |
| ---------------------- | ------------- | ----------------- |
| text                   | text          | null: false       |
| user                   | references    | foreign_key: true |

### Association

- belongs_to :user
- has_many   :likes
- has_many   :comments



## likes テーブル

| Column                 | Type          | Options           |
| -----------------------| ------------- | ----------------- |
| user                   | references    | foreign_key: true |
| tweet                  | references    | foreign_key: true |


### Association

- belongs_to :user
- belongs_to :tweet



## comments テーブル

| Column                 | Type          | Options           |
| -----------------------| ------------- | ------------------|
| content                | text          | null: false       |
| user                   | references    | foreign_key: true |
| tweet                  | references    | foreign_key: true |


### Association

- belongs_to :user
- belongs_to :tweet

## relationships テーブル

| Column                 | Type          | Options                        |
| -----------------------| ------------- | -------------------------------|
| user_id                | integer       | foreign_key: true              |
| follow_id              | integer       | foreign_key: {to_table: users} |


### Association

- belongs_to :user
- belongs_to :follow, class_name: 'User'

