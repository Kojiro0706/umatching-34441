# **UmajoUmatching**

# アプリケーション概要
## 馬や競馬好きの女性の方に特化した投稿掲示板交流サイト  
馬や競馬に興味のある方々が気軽に利用でき、交流を深められるアプリケーションです。投稿を通して馬に関する雑談や週末の競馬予想を始め、一緒に競馬場に行く人を募集することができ、投稿の詳細ページでユーザー同士でライブチャットを行うことが出来る。

# デプロイ後のURL
https://umatching-34441.herokuapp.com/
# テスト用アカウント
- name:テストユーザー1
- email:test@test.com
- password:ppp000
# 利用方法・DEMO
**`1.アクセスするとトップページに遷移する。`**  
**`2.ヘッダーの「LOGIN」ボタンをクリックし、ログインページに遷移する。`**  
**`3.上記テスト用アカウントにてログインすると一覧画面に遷移する。`**  
![0246f96fd60adb7f85a1cb25933fec59](https://user-images.githubusercontent.com/78080715/111986276-140de980-8b51-11eb-8cf6-d90daccf6c21.gif)
**`4.ヘッダーの「POST」ボタンをクリックし、新規投稿ページに遷移する。`**  
**`5.必要項目を入力して送信すると、投稿が登録され一覧ページに遷移する。`**
![7d26605f7dd51b4daa1ae89a1c73c375](https://user-images.githubusercontent.com/78080715/111991465-b4ffa300-8b57-11eb-9153-5d7cc46ca97d.gif)
**`6.一覧ページに表示されている画像をクリックすると投稿の詳細ページに遷移する。`**  
**`・投稿の詳細情報の閲覧が可能`**   
**`・非同期通信でチャットのやり取りが可能 `**  
![2a2e620da0ebb8c576c28f405fff19d2](https://user-images.githubusercontent.com/78080715/111992167-74ecf000-8b58-11eb-9f68-706dc500afa6.gif)
**`7.投稿の詳細ページのユーザー名をクリックするとユーザーの詳細ページに遷移する。`**  
**`・ユーザーのプロフィールが閲覧可能`**  
**`・ユーザーの投稿一覧が閲覧可能`** 
![d0c3775e81a1806a709ee0a25c7fdb95](https://user-images.githubusercontent.com/78080715/111992717-1116f700-8b59-11eb-9f7f-822cdc4b000b.gif)
**`8.ヘッダーのロゴマークをクリックするとトップページに遷移する。`**  
**`9.一覧ページの検索ページでカテゴリを選んで検索ボタンをクリックすると検索結果ページに遷移する。`**  
**`・選択されたカテゴリのみ閲覧可能`**  
![fa9cbcffcf7dcddaeb13d7ac3a4c710c](https://user-images.githubusercontent.com/78080715/111992959-618e5480-8b59-11eb-849a-14730b42d92d.gif)
**`10.ヘッダーの「LOGOUT」ボタンを押すとログアウトし、トップページに遷移する。`**  
**`11.ヘッダ-の「DATABASE」や「HORSECLUB」をクリックすると外部リンクに遷移する。`**  
**`・競走馬に関する情報サイトの閲覧が可能`**  
**`・競走馬の一口馬主クラブのサイトが閲覧可能`**  

 

# 目指した課題解決
女性のみにターゲットを絞り、馬や競走馬に興味があるが一歩踏み出せない方と競馬場にも観戦に訪れるコアなファンの方同士を繋ぎ活発に交流させ、競馬場に足を運んでもらうことが出来る。そして、競馬場の入場者の女性の比率を上げることで、競馬=ギャンブルという世間のイメージを変化させ、より魅力的なエンターテイメントだということを知ってもらうことが出来る。
# 機能一覧
| 機能                    | 概要                                |
| -----------------------|-------------------------------------|
| ユーザー管理機能          |新規登録・ログイン・ログアウトが可能       |
| 投稿登録機能             |画像付きで投稿が可能                    |
| 投稿一覧表示機能          | 各投稿が一覧ページで閲覧可能             |
| 投稿詳細機能             | 各投稿詳細が詳細ページで閲覧可能          |
| 投稿編集削除機能         |投稿者本人のみ投稿編集・削除が可能         |
| ユーザー詳細表示機能      |各ユーザーのプロフィール・投稿一覧が閲覧可能 |
| コメント機能             | 投稿詳細ページから非同期通信でコメントが可能|
| 検索機能                | 各投稿をカテゴリで絞り込んで閲覧可能       |
| ドロップダウンメニュー機能 | 関係のある外部リンクへのアクセスが可能     |


# テーブル設計
## usersテーブル

| Column    | Type   | Options                |
| --------  | ------ | -----------------------|
| email     | string | null: false,unique:true|
| password  | string | null: false            |
| name      | string | null: false            |
| profile   | text   | null: false            |
| history   | integer| null: false            |
| horse     | string |                        |

### Association

- has_many : builders
- has_many : comments


## buildersテーブル
| Column     | Type      | Options                        |
| ---------- | ----------| -------------------------------|
| title      | string    | null: false                    |
| description| text      | null: false                    |
| category_id| integer   | null: false                    |
| place      | string    |                                |
| user       |references | null: false, foreign_key: true |

### Association

- belongs_to : user
- has_many   : comments


## commentsテーブル
| Column    | Type      | Options                        |
| ----------| ----------| -------------------------------|
| text      | text      | null: false                    |
| user      |references | null: false, foreign_key: true |
| prototype |references | null: false, foreign_key: true |

### Association

- belongs_to : user
- belongs_to : comment

# ローカルでの動作方法
git clone https://github.com/Kojiro0706/umatching-34441  
$ cd umatching-34441  
$ bundle install  
$ rails db:create  
$ rails db:migrate  
$ rails s  

# 開発環境
・VScode   
・Ruby 2.6.5  
・Rails 6.0.3.5  
・MySQL 5.6.50  
・JavaScript  
・gem 3.0.3  
・heroku7.50.0  
・AWS(S3)  
