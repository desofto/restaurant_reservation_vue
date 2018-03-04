source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.4'

gem 'pg', '~> 0.21.0'
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'

gem 'stripe'

gem 'haml'

gem 'webpacker'

gem 'cancancan'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'font-awesome-rails'

gem 'bcrypt'

gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'redis', '~> 3.0'
gem 'redis-session-store'

gem 'grape'
gem 'grape-cancan'
gem 'grape-entity'

group :development, :test do
  gem 'pry-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: false

  gem 'capybara'
  gem 'capybara-webkit'

  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

gem 'rails_12factor', group: :production

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
