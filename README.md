# UITalk

## Usage

```sh
$ cp config/initializers/omniauth.rb.sample config/initializers/omniauth.rb
$ vi config/initializers/omniauth.rb

$ cp config/initializers/twitter.rb.sample config/initializers/twitter.rb
$ vi config/initializers/twitter.rb

$ cp config/initializers/secret_token.rb.sample config/initializers/secret_token.rb
$ vi config/initializers/secret_token.rb

$ bundle install --path=vendor/bundles
$ DB=sqlite bundle exec rake db:migrate

# spec for environments
$ bundle exec rspec spec/env/*_spec.rb
$ bundle exec rails s
```

## Development

**Repository**

+ https://github.com/ToQoz/UITalk

**Wiki**

+ https://github.com/ToQoz/UITalk/issues

**Issues**

+ https://github.com/ToQoz/UITalk/issues

**CI**

+ http://project.toqoz.net/jenkins/job/uitalk/
+ https://travis-ci.org/#!/ToQoz/UITalk
+ https://codeclimate.com/github/ToQoz/UITalk

## Contributes by Pull Request

```sh
$ git remote add upstream git://github.com/ToQoz/UITalk.git
$ git checkout -b develop upstream/develop
$ git checkout -b your-topic-branch

# run spec
$ script/spec

# send pull-request to develop branch
$ git commit -am "YOUR COMMIT MESSAGES"
$ git checkout develop
$ git pull upstream develop
$ git checkout your-topic-branch
$ git rebase develop
$ git push origin your-topic-branch
# pull-request to develop branch on web ui
```
