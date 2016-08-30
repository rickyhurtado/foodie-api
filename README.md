# Foodie API
Rails 5.0.0 API for foodie blogging platform.

## Development Setup
bundle install<br />
rake db:migrate<br />
rake db:seed<br />
rails server

## Test Setup
rake db:migrate ENV=test<br />
rake db:fixtures:load RAILS_ENV=test<br />
rails test test
