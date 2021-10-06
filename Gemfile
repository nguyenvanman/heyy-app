source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.3'
gem 'bcrypt',         '3.1.12'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10.0'
gem "bootstrap-sass", ">= 3.4.1"
gem 'bootstrap-will_paginate', '1.0.0'
gem 'will_paginate',           '>= 3.1.7'
gem 'coffee-rails', '~> 4.2'
gem 'sidekiq', '~> 5.2.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'dotenv'
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails', groups: [:development, :test]

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]