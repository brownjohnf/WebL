require 'spec_helper'

describe SessionsController do
	describe "when creating a new session (logging in)" do
		
		before(:each) do
		  @attr = {:name => "dennis", :password => "secret"}
		end
		
		it "should render the login form again if wrong credentials are used" do
			post :create, :session => @attr
			response.should render_template('new')
		end
		
		it "should redirect to the root path if right crendentials are used" do
			User.create!(@attr.merge(:password_confirmation => "secret", :email => "test@test.com"))
			post :create, :session => @attr
			response.should redirect_to root_path
		end
	end
end