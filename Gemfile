source 'http://rubygems.org'

gem 'rails', '~>3.1'
gem 'jquery-rails'
gem 'haml'
gem 'cancan'
gem 'omniauth-github'
gem 'gravatar_image_tag'
gem 'will_paginate', '~> 3.0.0'
gem 'bcrypt-ruby'

# Formatting and code highlighting
gem 'redcarpet' 
gem 'nokogiri'
gem 'coderay'

group :production do
	gem 'therubyracer'
	gem 'pg'
end

group :assets do
  gem 'sass-rails', "~> 3.1"
  gem 'coffee-rails', "~> 3.1"
  gem 'uglifier'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
	gem 'webrat'
  gem 'launchy' # Provides save_and_open_page in rspecs
	gem 'factory_girl_rails', '1.0'	
	gem 'mocha'
end

group :development do
	gem 'capistrano'
	gem 'sqlite3'
  gem 'rspec-rails'
	gem 'annotate'
	gem 'nifty-generators'
	gem 'faker'
	gem 'spork', '~> 0.9.0.rc'
	gem 'autotest'
	gem 'autotest-rails-pure'
	gem 'autotest-growl'	
	gem 'pry'
end
