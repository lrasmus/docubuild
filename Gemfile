source 'https://rubygems.org'

# Upgraded to Rails 5.0 in October 2017
gem 'rails', '>=5.0', '<5.1'
gem 'pg', '~> 0.21'

# Allows soft delete of models
gem "paranoia", "~> 2.0"

# Authentication and authorization gems
gem 'devise'
gem "pundit"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem "twitter-bootstrap-rails"
gem 'tinymce-rails', '>=4.7.1'
gem 'fastimage'
gem 'font-awesome-rails'

gem 'rubyzip',  "~> 1.1", require: 'zip'
gem 'rest-client'

# API management
gem 'active_model_serializers'
gem 'apipie-rails'
gem 'jwt'
gem 'rack-cors', :require => 'rack/cors'


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'haml'
gem 'haml-rails'

# Track changes to models
gem 'paper_trail'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :test do
  gem 'rails-controller-testing'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Used for local SMTP needs (for Devise)
  gem 'mailcatcher'

  gem 'rails-erd'
end

gem 'figaro'
gem 'puma', '>= 4.3.8'
group :development do
  gem 'capistrano'
  gem 'capistrano-rails', require: false
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
end


gem 'tzinfo-data'