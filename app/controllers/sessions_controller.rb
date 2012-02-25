class SessionsController < ApplicationController  
	skip_authorization_check
  protect_from_forgery :except => :create_from_github
	
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
  
  def new_from_github
    store_referer
    redirect_to "/auth/github"
  end
  
  def create_from_github
    omniauth = request.env["omniauth.auth"]
    @user = User.find_by_github_uid(omniauth["uid"]) || User.create_from_omniauth(omniauth)
    sign_in @user
    redirect_back_or root_path, :notice => "Welcome, #{@user.name}"
  end
  
  def failure_from_github
    flash[:error] = "Error logging in with GitHub. #{params[:message]}"
    redirect_to root_path
  end
end