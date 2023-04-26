source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"
gem "cssbundling-rails"
gem "jsbundling-rails"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_bot_rails'
  gem 'capybara'
end

group :development do
  gem "web-console"
end

group :test do
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "faker"
  gem "rails-controller-testing"
  gem "shoulda-matchers"
end
