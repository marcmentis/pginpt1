RSpec.configure do |config|

#Simplifying FactoryGirl syntax (i.e., drop 'FactoryGirl')
  config.include FactoryGirl::Syntax::Methods

# Add response.headers to response object
  # Capybara.register_driver :rack_test do |app|
  #   Capybara::RackTest::Driver.new(app, :headers => {'HTTP_REMOTE_USER' => 'NotBlank'})
  # end

# Make 'Launchy' display page WITH CSS and JavaScript
  # Capybara.asset_host = 'http://localhost:3000'

# Run/Exclude tagged specs
    # Will run ONLY 'a_feature' tags
	    # config.filter_run a_feature: true 
	    #config.filter_run a_test:true
    # Will NOT run 'a_feature' tags
      # config.filter_run_excluding a_failure: true  

# Capybara normally hides hidden objects - to show them change
	# Capybara.ignore_hidden_elements = false

end