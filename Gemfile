source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem "carrierwave", "~> 2.2"
gem "devise", "~> 4.8"
gem "devise-i18n", "~> 1.10"
gem "dotenv-rails", "~> 2.8"
gem "fog-aws", "~> 3.14"
gem "font-awesome-rails", "~> 4.7"
gem 'jbuilder', '~> 2.7'
gem 'listen', '~> 3.3'
gem "net-imap", "~> 0.2.3", require: false
gem "net-pop", "~> 0.1.1", require: false
gem "net-smtp", "~> 0.3.1", require: false
gem 'puma', '~> 5.0'
gem "pundit", "~> 2.2"
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem "rails-i18n", "~> 7.0"
gem "resque", "~> 2.4"
gem "rmagick", "~> 4.2"
gem "rspec-rails", "~> 5.1"
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'capistrano', '~> 3.17'
  gem 'capistrano-rails', '~> 1.6'
  gem 'capistrano-passenger', '~> 0.2.1'
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'capistrano-bundler', '~> 2.1'
  gem "capistrano-resque", "~> 0.2.3", require: false

  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

group :production do
  gem "pg", "~> 1.4"
end
