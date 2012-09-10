# UITalk
## Documents

[Wiki](https://github.com/ToQoz/UITalk/wiki)


## 実行

```sh
$ cp config/initializers/omniauth.rb.sample config/initializers/omniauth.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/omniauth.rb

$ cp config/initializers/twitter.rb.sample config/initializers/twitter.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/twitter.rb

$ cp config/initializers/secret_token.rb.sample config/initializers/secret_token.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/secret_token.rb

# gem のインストール先はvendor/bundlesで
$ bundle install --path=vendor/bundles
$ DB=sqlite bundle exec rake db:migrate

# 環境とかのテスト
$ DB=sqlite bundle exec rspec spec/env/*_spec.rb
# secret_tokeとかomniauthの設定ファイルがあるかどうかとかのテスト
$ DB=sqlite bundle exec rspec spec/env/*_spec.rb

# DB名を環境変数に入れれば良いというだけ
$ DB=sqlite bundle exec rails s
```

## Contributes by Pull Request

```sh
$ git remote add upstream git://github.com/ToQoz/UITalk.git
$ git checkout -b develop upstream/develop
$ git checkout -b your-topic-branch

# === 作業 ===
# === 作業終了 ===

# テスト通るか確認
$ DB=sqlite bundle exec rake db:migrate test
$ DB=sqlite bundle exec rake spec
$ DB=sqlite bundle exec rspec spec/env/*_spec.rb

$ git commit -am "YOUR COMMIT MESSAGES"
# 作業中にリモートに変更あったら {{{
$ git checkout develop
$ git pull upstream develop
$ git checkout your-topic-branch
$ git rebase develop
# テスト通るか確認
$ DB=sqlite bundle exec rspec spec/env/*_spec.rb
$ DB=sqlite bundle exec rake spec models
# }}}

$ git push origin your-topic-branch
```
