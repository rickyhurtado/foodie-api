# Foodie API
[Foodie API v1.0.1-beta](https://github.com/rickyhurtado/foodie-api/tree/v1.0.1-beta) powered by Rails 5.0.0 API and Ruby 2.3.1.

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
bin/rails test
```
Specific folder:
```
bin/rails test test/controllers
```

Specific file:
```
bin/rails test test/controllers/users_controller_test.rb
```

Specific line:
```
bin/rails test test/controllers/users_controller_test.rb:24
```
