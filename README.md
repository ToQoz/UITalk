# UITalk
## 実行

```sh
$ cp config/initializers/omniauth.rb.sample config/initializers/omniauth.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/omniauth.rb

$ cp config/initializers/secret_token.rb.sample config/initializers/secret_token.rb
# 自分の環境に合わせて Change it! 部分を変える.
$ vi config/initializers/secret_token.rb

# gem のインストール先はvendor/bundlesで
$ bundle install --path=vendor/bundles
$ DB=sqlite bundle exec rake db:migrate

# 環境とかのテスト
$ DB=sqlite be rspec spec/env/*_spec.rb
# secret_tokeとかomniauthの設定ファイルがあるかどうかとかのテスト
$ DB=sqlite be rspec spec/env/*_spec.rb

# DB名を環境変数に入れれば良いというだけ
$ DB=sqlite bundle exec rails s
```

## Git便利hooks
### Masterへのコミット禁止

```sh
$ vi .git/hooks/pre-commit
----------------------------

#! /bin/sh
# https://github.com/bleis-tift/Git-Hooks/blob/master/pre-commit

get_git_branch_name(){
    branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
           "$(git describe --contains --all HEAD)"
    echo ${branch##refs/heads/}
}
is_on_master_branch() {
    if [ "$(get_git_branch_name)" = "master" ]; then
        return 0
    fi
    return 1
}

if [ -z "$(git branch)" ]; then
    exit 0
fi

is_on_master_branch
if [ $? -eq 0 ]; then
    echo "can't commit on master branch."
    echo "please commit on topic branch."
    exit 1
fi

exit 0
----------------------------
$ chmod +x .git/hooks/pre-commit
```

## Contributes by Pull Request

```sh
$ git remote add upstream git://github.com/ToQoz/UITalk.git
$ git checkout -b develop upstream/develop
$ git checkout -b your-topic-branch

# === 作業 ===
# === 作業終了 ===

# テスト通るか確認
$ DB=sqlite be rspec spec/env/*_spec.rb
$ DB=sqlite be rake spec models

$ git commit -am "YOUR COMMIT MESSAGES"
# 作業中にリモートに変更あったら {{{
$ git checkout develop
$ git pull upstream develop
$ git checkout your-topic-branch
$ git rebase develop
# テスト通るか確認
$ DB=sqlite be rspec spec/env/*_spec.rb
$ DB=sqlite be rake spec models
# }}}

$ git push origin your-topic-branch
```
