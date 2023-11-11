source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "rack-cors"
gem "sprockets-rails"

# mysql using triloy
# gem "trilogy"
gem "mysql2"

# grape
gem "grape"
gem "grape-swagger"
gem "grape-swagger-rails"

# Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

group :development do
  gem 'capistrano'
  gem "capistrano-rails"
  gem "capistrano-passenger"
  gem "capistrano-rbenv"
end


group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
end


gem "ed25519", "~> 1.3"

gem "bcrypt_pbkdf", "~> 1.1"

gem "base64", "= 0.1.1"

gem "httparty", "~> 0.21.0"
