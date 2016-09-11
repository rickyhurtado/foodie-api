# Foodie API
Rails 5.0.0 API and Ruby 2.3.1 for foodie blogging platform.

## Development Setup
```
bundle install
rake db:migrate
rake db:seed
rails server
```

## Test Setup
```
rake db:migrate ENV=test
rake db:fixtures:load RAILS_ENV=test
rails test test
```
