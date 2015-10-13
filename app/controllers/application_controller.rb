class ApplicationController < ActionController::Base
  # Expose methods in these modules to all applicatins/views
  # I.E. DON"T have to have 'include SessionValues' in each controller
  include SessionValues
  include CurrentUser
  include PhiAuditing

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Check user is authorized and confirmed before every action
  before_action :authorized_and_confirmed
end
