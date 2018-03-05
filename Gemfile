source "https://rubygems.org"

ruby "2.3.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "puma", "~> 3.7"
gem "rails", "~> 5.1.5"
gem "sqlite3"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem "jbuilder", "~> 2.5"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 3.5"
  gem "rubocop"
  gem "swagger-docs"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", require: false
end
