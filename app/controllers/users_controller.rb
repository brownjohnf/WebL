class UsersController < ApplicationController
	load_and_authorize_resource
	
	def show
	end
	
	def new
	end
	
	def create
		if @user.save
			sign_in @user
			flash[:success] = "Registration Successful!"
			redirect_to @user
		else
			flash.now[:error] = "Oops! There was an error saving your profile."
			render 'new'
		end
	end

	def edit
	end
	
	def update
		params[:user].delete :name # don't allow username changes
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			flash.now[:error] = "Oops! There was an error updating your profile."
			render 'edit'
		end
	end
end

