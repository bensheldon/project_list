source 'https://rubygems.org'
ruby_version = File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip
ruby ruby_version

gem 'bootsnap', require: false
gem 'kramdown'
gem 'pg'
gem 'pry-rails'
gem 'puma'
gem 'rails', '~> 5.2'
gem 'selenium-webdriver'
gem 'sentry-raven'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier'
gem 'webpacker'

group :production do
  gem 'aws-sdk-s3', require: false
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'launchy', require: false
  gem 'rspec_junit_formatter'
  gem 'webmock'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'eefgilm'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
