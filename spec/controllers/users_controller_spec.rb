require 'spec_helper'

describe UsersController do
	before(:each) do
	  @user = Factory :user
	end
	
	describe "Guests" do
		
		it "should be able to view a users profile" do
			get :show, :id => @user
			response.should be_successful
		end
		
		it "should not be able to edit, update" do
		  get :edit, :id => @user
			response.should redirect_to root_path
		end
		
		it "should be able to open the register page" do
		  get :new
			response.should be_successful
			response.should render_template 'new'
		end
		
		it "should be able to register" do
			@attr = {
				:name => "Example user 2", 
				:email => "user-1@example.com", 
				:password => "secret",
				:password_confirmation => "secret"
			}
			
			lambda do
				post :create, :user => @attr
				assigns[:user].name.should == @attr[:name]
			end.should change(User, :count).by(1)
		end

		it "should not be able to set roles" do
			@attr = {
				:name => "Example user 2", 
				:email => "user-1@example.com", 
				:password => "secret",
				:password_confirmation => "secret",
				:roles => ["admin", "author"]
			}
			
			lambda do
				post :create, :user => @attr
				assigns[:user].name.should == @attr[:name]
				assigns[:user].has_role?("admin").should_not == true
				assigns[:user].has_role?("author").should_not == true
			end.should change(User, :count).by(1)
		end
	end

	describe "Registered users" do
		
		before(:each) do
			@currentuser = Factory(:user, :name => "registered user", :email => "registered@example.com")
		  sign_in @currentuser
		end
		
		it "should be able to view a users profile" do
			get :show, :id => @user
			response.should be_successful
		end
		
		it "should not be able to edit, update other users" do
		  get :edit, :id => @user
			response.should redirect_to root_path
		end
		
		it "should be able to edit his own profile" do
			get :edit, :id => @currentuser
			response.should be_successful
		end
		
		it "should be able to update his own profile (email and pass)" do
			put :update, :id => @currentuser, :user => {:email => "new-email@example.com"}
			assigns[:user].email.should == "new-email@example.com"
			response.should redirect_to @currentuser
		end
		
		it "should not be able to open the register page" do
		  get :new
			response.should_not be_successful
			response.should redirect_to root_path
		end
		
		it "should not be able to register" do
			@attr = {
				:name => "Example user 2", 
				:email => "user-1@example.com", 
				:password => "secret",
				:password_confirmation => "secret"
			}
			
			lambda do
				post :create, :user => @attr
				assigns[:user].name.should == @attr[:name]
			end.should change(User, :count).by(0)
		end

		it "should not be able to set roles" do
			@attr = {
				:name => "Example user 2", 
				:email => "user-1@example.com", 
				:password => "secret",
				:password_confirmation => "secret",
				:roles => ["admin", "author"]
			}
			
			lambda do
				post :create, :user => @attr
				assigns[:user].name.should == @attr[:name]
				assigns[:user].has_role?("admin").should_not == true
				assigns[:user].has_role?("author").should_not == true
			end.should change(User, :count).by(0)
		end
	end

end


