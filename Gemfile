# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use dotenv to load environment variables
gem 'dotenv-rails', '~> 2.5', groups: %i[development test]
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Bootstrap for style framework
gem 'bootstrap', '~> 4.1.3'
# Bootstrap requires jquery
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use Font Awesome for iconography
gem 'font-awesome-sass', '~> 4.7'
# Use HAML instead of ERB
gem 'haml-rails', '~> 1.0'
# Use RedCarpet for markdown
gem 'redcarpet', '~> 3.4'
# Use CodeRay for syntax highlighting
gem 'coderay', '~> 1.1', '>= 1.1.2'
# Use clearance for authentication
gem 'clearance', '~> 1.16', '>= 1.16.1'
# Turbolinks makes navigating your web application faster.
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a console
  gem 'pry-byebug', '~> 3.6'
  # Use RSpec for testing
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  # Use for controller test
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
  # Use FactoryBot for test data
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use pry for console
  gem 'pry-rails', '~> 0.3.9'
  # Rubocop for code style guidelines
  gem 'rubocop', '~> 0.59.2'
  # Reek for code smells
  gem 'reek', '~> 5.3'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  # Use faker to generate test data
  gem 'faker', '~> 1.9', '>= 1.9.1'
  # Improved validations for testing
  gem 'shoulda-matchers', '~> 4.0'
  # Reset database to clean state for testing
  gem 'database_cleaner', '~> 1.7'
end
