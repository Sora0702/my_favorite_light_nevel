# okinove

* okinoveはお気に入りの小説やweb小説を記録し、感想を共有するサービスです。

* 読書家さんたちと感想の共有や新しい小説との出会い、自分のお気に入り小説の管理を目的としています。

* アプリケーションの確認は[こちら](https://okinove-de71f085f06e.herokuapp.com/)

***

1. [DEMO](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#demo)
2. [Features](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#features)
3. [Technology used]()
4. [Functions](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#functions)
6. [Usage](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#usage)

# DEMO

![okinove](https://github.com/Sora0702/my_favorite_light_nevel/assets/124307131/62de158d-cd52-443b-bd90-fdb253a07e53)

# Features

# Technology used

* Ruby 3.2.1
* Ruby on Rails 6.1.7.3
* heroku
* AWS(IAM, S3)
* RSpec
* Rakuten API
* なろう小説API

# Functions

* ユーザー登録、編集、削除機能
* ログイン、ログアウト機能(devise)
* 楽天apiとなろう小説apiを使った小説の検索機能
* 小説の感想投稿と削除機能(Ajax)
* 小説のお気に入り機能(Ajax)
* お気に入りした小説の確認機能


# Usage

本アプリの使用にあたり、yarnおよびwebpackerのインストールが必要となります。
ローカル環境での利用方法は以下となります。

1. リポジトリをクローン
```
$ git clone https://github.com/Sora0702/my_favorite_light_nevel.git
```
2. bundleのインストール
```
$ bundle install
```
3. データベースの設定
```
$ rails db:migrate
```
4. seedファイルの設定
```
$ rails db:seed
```
5. yarnのインストール
```
$ yarn install
```
6. webpackerインストール
```
$ yarn add @rails/webpacker
```
7. 環境変数を設定
```
$ export NODE_OPTIONS=--openssl-legacy-provider
```
8. webpackerのコンパイル
```
$ bundle exec rails webpacker:compile
```
9. サーバーの起動
```
$ rails s
```
