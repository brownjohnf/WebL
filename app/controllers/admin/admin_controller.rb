class Admin::AdminController < ApplicationController
	skip_authorization_check
	before_filter :authenticate, :authenticate_as_admin
	
	private
	
	def authenticate_as_admin
		#redirect_to root_url unless signed_in?
		unless current_user.has_role? :admin
			flash[:error] = "You are not authorized to view this page"
			redirect_to root_url
		end
	end
end
