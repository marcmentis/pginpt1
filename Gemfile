source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# jQuery UI and Themes
gem 'jquery-ui-rails', '~> 5.0'
gem 'jquery-ui-themes'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Allows document 'ready' event to work properly (Remember to change js manifest)
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# DB for all environments
# gem "activerecord-oracle_enhanced-adapter", "~> 1.5.0"
# gem 'ruby-oci8', '~> 2.1.0'
gem 'sqlite3'



# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'sqlite3'
  gem 'mysql2'
  gem 'byebug'
  gem 'rspec-rails'  # Includes RSpec in wraper with rails-specific features
  gem 'factory_girl_rails'  # Replaces Rails' default fixtures with factories
  gem 'shoulda-matchers', require: false # association matchers v2.8.0
  gem 'faker'	# Generates names, email addresses etc
end

group :test do
  gem 'capybara'	# Simulates user behavior
  gem 'database_cleaner'	# makes each spec run with clean test db
  gem 'launchy'		# Opens default browser on demand - show what app rendering - useful with debugging
  gem 'selenium-webdriver'	# for testing JavaScript-based browser interactions with Capybara
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'better_errors' # Better error page
  gem 'binding_of_caller' # Adds functionality to better_errors
  gem 'meta_request'  # Works with RailsPanel in Chrome (Add RailsPanel from google store)
end

# Can run bundle --without production on Mac and not have Oracle error
group :production do
	#DB's NB CHANGE for deploy to VM GITLAB and OMH.
	# gem "activerecord-oracle_enhanced-adapter", "~> 1.5.0"
	# gem 'ruby-oci8', '~> 2.1.0'
	# gem 'mysql2'
	# gem 'sqlite3'
	# gem 'faker'
end

