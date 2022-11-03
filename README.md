
# user

|    カラム名     | データ型 |
|:---------------:|:--------:|
|      name       |  string  |
|      email      |  string  |
| password_digest |  string  |


# task

| カラム名 | データ型 |
| -------- | -------- |
| title    | string   |
| content  | text     |
| limit    | date     |
| status   | integer  |
| priority | integer  |


# label

| カラム名 | データ型 |
| -------- | -------- |
| name     | string   |


# favorite

| カラム名 | データ型 |
| -------- | -------- |
|          |          |


# Herokuへのデプロイ手順

1. Herokuにデプロイするアプリに位置することを確認して`heroku create`を実行する
2.  GemfileにGemを追加し`bundle install`を実行する
```
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
```
3. コミットする
```
$ git add .
$ git commit -m "init"
```
4. Heroku buildpackを追加する 
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
5. Herokuにデプロイをする
```
$ git push heroku master
```
6. データベースの移行をする
```
$ heroku run rails db:migrate
```