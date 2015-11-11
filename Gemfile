source 'https://rubygems.org'

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

gem 'mysql2', '0.3.11'
gem 'will_paginate', '~> 3.0'
gem 'chartkick'
gem 'groupdate'

# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'
  gem 'bootstrap-sass'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

# jquery
gem 'jquery-rails', github: 'rails/jquery-rails'
gem 'jquery-ui-rails'

gem 'font-awesome-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# renderers
gem 'haml-rails', github: 'indirect/haml-rails'

# authentication
gem 'devise'

# UI components
gem 'simple_form', github: 'plataformatec/simple_form', branch: 'master'
gem 'simple-navigation', github: 'andi/simple-navigation'
gem 'simple-navigation-bootstrap'

# configuration
gem 'scoped_choices'
gem 'hashie', github: 'intridea/hashie'
# 3rd party api's
gem 'github_api'

# slugs
#gem 'friendly_id', github: 'FriendlyId/friendly_id'

gem 'net-ssh'

#gem 'paper_trail', github: 'airblade/paper_trail'

# activity feed
gem 'public_activity', github: 'pokonski/public_activity'

# sidekiq gems
gem 'sidekiq'

#gem 'exception_notification', github: 'smartinez87/exception_notification'
#gem 'exception_notification'
gem 'json', '~> 1.7.7'



group :development do

  #gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano'
  unless ENV['RM_INFO']
    gem 'debugger'
    gem 'pry-rails'
    gem 'pry-nav'
  end
  gem 'thin'
  gem 'foreman'
  gem 'better_errors'
  gem 'foreman'
end

group :test do
  #gem 'minitest', '~>5.0.3'
  #gem 'minitest', '5.1.0'
  gem 'simplecov'
  gem 'forgery', '0.5.0'
  gem 'factory_girl_rails', '4.1.0'
  gem "rspec-rails", github: 'rspec/rspec-rails'
  gem 'rspec-sidekiq'
  gem 'timecop'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'capybara', github: 'jnicklas/capybara'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'rb-fsevent'
  gem 'poltergeist', github: 'jonleighton/poltergeist'
  gem 'connection_pool'
end
