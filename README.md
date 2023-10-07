# okinove

* okinoveはお気に入りの小説やweb小説を記録し、感想を共有するサービスです。
* 読書家さんたちと感想の共有や新しい小説との出会い、自分のお気に入り小説の管理が可能です。

***

1. [URL](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#url)
2. [DEMO](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#demo)
3. [Features](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#features)
4. [Technology](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#technology)
5. [Functions](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#functions)
6. [ER diagram](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#er-diagram)
7. [Usage](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#usage)
8. [License](https://github.com/Sora0702/my_favorite_light_nevel/blob/main/README.md#license)

# URL
https://okinove-de71f085f06e.herokuapp.com/

# DEMO

![okinove](https://github.com/Sora0702/my_favorite_light_nevel/assets/124307131/62de158d-cd52-443b-bd90-fdb253a07e53)

# Features

本アプリの作成の経緯について、新しい小説を探すときに商業小説とweb小説のレビューが同時に確認できるようなサービスが見当たらないためです。
商業小説のユーザーとweb小説のユーザーが触れ合う機会を作ることでより、より読書の幅が広がると考えました。

本アプリの特徴は、通常の小説とweb小説について感想の共有やお気に入りの登録ができることです。
これにより、商業作品やweb小説のどちらか一方であったユーザーが新しい作品に出会える機会を提供します。
また、お気に入り機能により好きな商業作品とweb小説の管理が可能であり、それぞれ作品のページへのリンクが存在するため、容易に確認することができます。

# Technology

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

# ER diagram
![erd.pdf](https://github.com/Sora0702/my_favorite_light_nevel/files/12838991/erd.pdf)

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

# License

[MIT License](https://opensource.org/license/mit/)
