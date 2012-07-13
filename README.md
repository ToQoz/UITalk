# 実行

```
$ cp config/initializers/omniauth.rb.sample cp config/initializers/omniauth.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/omniauth.rb

$ cp config/initializers/secret_token.rb.sample config/initializers/secret_token.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/secret_token.rb

# DB名を環境変数に入れれば良いというだけ
$ DB=sqlite bundle exec rails s
```
