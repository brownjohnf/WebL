class SessionsController < ApplicationController  
	skip_authorization_check
	
  def new  
  end  
  
	def create  
	  user = User.find_by_name(params[:session][:name])
	  if user && user.authenticate(params[:session][:password])  
	    sign_in user
			flash[:success] = "Logged in!"
	    redirect_back_or root_path
	  else  
	    flash.now[:alert] = "Invalid name or password"  
	    render "new"  
	  end  
	end
  
  def destroy  
    sign_out
    redirect_to root_url, :notice => "Logged out!"  
  end  
end