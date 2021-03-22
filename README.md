# UmajoUmatching

# アプリケーション概要
## 馬や競馬好きの女性の方に特化した投稿掲示板交流サイト  
馬や競馬に興味のある方々が気軽に利用でき、交流を深められるアプリケーションです。投稿を通して馬に関する雑談や週末の競馬予想を始め、一緒に競馬場に行く人を募集することも出来る。

# URL
# テスト用アカウント
# 利用方法
# 目指した課題解決
# 洗い出した要件
# ローカルでの動作方法

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
