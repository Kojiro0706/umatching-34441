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
