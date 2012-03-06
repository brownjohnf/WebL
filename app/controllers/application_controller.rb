class ApplicationController < ActionController::Base
  protect_from_forgery
	check_authorization
  include SessionsHelper

  around_filter :disable_gc

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied: #{exception.message}"
		redirect_to root_url
	end
	
	private
	  
	  def disable_gc
      GC.disable
      begin
        yield
      ensure
        GC.enable
        GC.start
      end
	  end
end
