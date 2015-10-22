class WidgetsController < ApplicationController
  def index
  	@request = request
    @response = response
# byebug
    authorize :widget, :index?
  end
end
