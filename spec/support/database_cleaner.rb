RSpec.configure do |config|
# CAPSTONE RAILSAPPS
	# RSpec.configure do |config|

	# 	config.use_transactional_fixtures = true

	# 	config.before(:suite) do
	# 	DatabaseCleaner.clean_with(:truncation)
	# 	end

	# 	config.before(:each) do
	# 	DatabaseCleaner.strategy = :transaction
	# 	end

	# 	config.before(:each, :js => true) do
	# 	DatabaseCleaner.strategy = :truncation
	# 	end

	# 	config.before(:each) do
	# 	DatabaseCleaner.start
	# 	end

	# 	config.append_after(:each) do
	# 	DatabaseCleaner.clean
	# 	end

	# end

# EVERYDAYRAILSAPPS - from code
	config.use_transactional_fixtures = true
	config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with :truncation
    end

    config.around(:each) do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

# EVERYDAYRAILSAPPS - from Book
	# config.use_transactional_fixtures = false
	# config.before(:suite) do DatabaseCleaner.strategy = :truncation
	# end
	# config.before(:each) do DatabaseCleaner.start
	# end
	# config.after(:each) do DatabaseCleaner.clean
	# end

end