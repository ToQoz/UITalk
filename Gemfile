source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'normalize-rails'
gem 'jquery-rails'
gem "omniauth-twitter"
gem "twitter"
gem 'bcrypt-ruby'
gem 'uuidtools'

group :development do
  gem 'rails-erd'
end

group :test, :development do
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-nav'
  gem 'hirb'
  gem 'rspec-rails', ">= 2.8.1"
  gem 'rails-sh'
end

group :test do
  gem 'spork'
  gem 'database_cleaner', ">= 0.7.1"
  gem 'cucumber-rails', ">= 1.2.1", :require => false
  gem 'capybara', ">= 1.1.2"
  gem 'rspec-rails-mocha', :require => false
  gem "factory_girl_rails", ">= 1.6.0", :require => false
  # Code coverage for Ruby 1.9
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
