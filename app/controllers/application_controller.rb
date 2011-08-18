class ApplicationController < ActionController::Base
  protect_from_forgery
	check_authorization
  include SessionsHelper

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied: #{exception.message}"
		redirect_to root_url
	end
end
