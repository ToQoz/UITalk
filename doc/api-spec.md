# API Spec

## 投稿
### GET /posts/:id

```javascript
{
  id: "",                                   // 投稿のID (Mongo[ORMapper]の仕様に合わせる)
  img: "http://example.com/iamges/foo.png", // 画像のURL
  body: "",                                 // 投稿文
  tags: [ // Tagの情報
    { id: "1", name: "Ruby" },
    { id: "4", name: "JavaScript" },
    { id: "6", name: "Python" }
  ],                          
  stock_count: 3,                           // ストックされた回数
  eval: { // 評価情報
    good: 2,                                // goodされた回数
    bad: 3                                  // badされた回数
  },
  user: { // ユーザー情報
    id: "5",                                // UserのID
    name: "ToQoz",                          // Userの名前
    folower_count: 1,                       // UserのFollowerの数
    folowee_count: 1,                       // UserのFollowしている人の数
    stock_count: 5
  },
  created: 1336801581163,                   // Unix Timestamp Mongo[ORMapper]の仕様に合わせる
  updated: 1336801581163                    // 同上
}
```

### GET /posts

```javascript
[
  embed(GET /posts/:id),
  embed(GET /posts/:id)
]
```

## タグ
### GET /tags/:name

```javascript
{
  id: "",                                   // 投稿のID (Mongo[ORMapper]の仕様に合わせる)
  name: "twitter",                          // サービス名称
  url: "htttp://twitter.com",               // サービスURL   
  img: "http://example.com/iamges/foo.png", // サービス画像のURL
  follower_count:12,                        // タグをフォローしている人の数
  post_count:22                             // このタグで投稿された数
}
```

### GET /tags

```javascript
[
  embed(GET /tags/:name),
  embed(GET /tags/:name)
]
```

## ストック
### GET /stocks

```javascript
{ 
  post: { //投稿情報
    id:"",                                        // 投稿ID
    body:"",                                      // 投稿本文
    img:"",                                       // 画像URL
    user_name: "ToQoz",                           // 投稿したユーザ名
    user_profile_img:"http://hoge/hoge.jpg"       // 投稿したユーザ画像
    stock_count: 5,                               // ストックされている数
    comment_count: 10,                            // 投稿に回答された数
    users: [                                      // ストックしているユーザ情報
      { name:"honbin", img:"http:///hogehoge/hoge.jpg" },
      { name:"honbin", img:"http:///hogehoge/hoge.jpg" }
    ],
    tag: { //タグ情報
      name:"twitter",                             // サービス名
      img:"http:///hogehoge/hoge.jpg"             // サービス画像
    },
    eval: { //評価情報
      good:3,                                     //いいね
      bad:2                                       //よくないね
    }
    created: 1336801581163,                       // 投稿登録日時
    updated: 1336801581163                        // 投稿更新日時
  },
  created: 1336801581163,                         // ストック登録日時
  updated: 1336801581163                          // ストック更新日時
}
```

## コメント
### GET /comments/:post_id

```javascript
{
  id:"",                                         // コメントID
  body:"たしかにー",                             // 内容
  eval: { //評価情報
    good:2,                                      // いいね
    bad:2                                        // よくないね
  },
  user: { //ユーザ情報
    name:"honbin",                               // ユーザ名
    img:"http://hogehoge/hoge.jpg",              // ユーザ画像
  },
  created,                                       // 登録日時
  updated                                        // 更新日時
}
```

## ユーザー
### GET /users/:name

```javascript
{
  name:"ToQoz",                                   // 名前
  img:"http://hogehoge.com/hoge.jpg",             // ユーザ画像
  url:"http://toqoz.net",                         // ユーザURL
  email:"toqoz403@gmail.com",                     // メールアドレス
  location:"Yokohama",                            // 住んでる場所
  created:1336801581163,                          // 登録日時
  following_count:33,                             // フォローしている数           
  follwer_count:12,                               // フォロワー数
  stock_count:12,                                 // ストック数
  stocked_count:12,                               // ストックされた数
  good_count:100,                                 // goodと評価された数
  bad_count:2,                                    // badと評価された数
  post_count:100,                                 // 投稿数
  following_tag_count:34                          // フォローしているタグの数
}
```

## フォロー
### GET /following

```javascript
[
  embed(GET /users/:name),
  embed(GET /users/:name)
]
```

### GET /followers

```javascript
[
  embed(GET /users/:name),
  embed(GET /users/:name)
]
```

## 通知
### GET /notifications

```javascript
{
  name:"ToQoz",                                  // お知らせへのアクションを行った人
  act_div_name:"follow",                         // アクション区分名(follow or stock or good..)
  act_url:"http://hogehoge.com",                 // 対象アクションへのURL
  created:1336801581163,                         // 登録日時
}
```
