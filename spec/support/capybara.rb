RSpec.configure do |config|

#Simplifying FactoryGirl syntax (i.e., drop 'FactoryGirl')
  config.include FactoryGirl::Syntax::Methods

  # Add response.headers to response object
	  # Capybara.register_driver :rack_test do |app|
	  #   Capybara::RackTest::Driver.new(app, :headers => {'HTTP_REMOTE_USER' => 'NotBlank'})
	  # end

  # Make 'Launchy' display page WITH CSS and JavaScript
	  Capybara.asset_host = 'http://localhost:3000'

end