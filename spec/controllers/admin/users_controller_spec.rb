require 'spec_helper'

describe Admin::UsersController do
	fixtures :users
	
	describe "as an admin" do
		before(:each) do
		  @user = Factory :user, :roles => ['admin']
			sign_in @user
		end

	  describe "GET 'index'" do
	    it "should be successful" do
	      get 'index'
	      response.should be_success
	    end
	  end

	  describe "GET 'show'" do
	    it "should be successful" do
	      get 'show', :id => 1
	      response.should be_success
	    end
	  end

	  describe "GET 'new'" do
	    it "should be successful" do
	      get 'new'
	      response.should be_success
	    end
	  end
	
		describe "POST 'create'" do
			it "should create a new user" do
				lambda do
					post 'create', :user => { :name => 'test user', :email => 'test@test.com', :password => 'secret', :password_confirmation => 'secret' }
				end.should change(User, :count).by(1)			  
			end
			
			it "should be able to set ALL attributes" do
				lambda do
					post 'create', :user => { :name => 'test user', :email => 'test@test.com', :password => 'secret', :password_confirmation => 'secret', :roles => ['admin'] }
					assigns[:user].roles.should == ['admin']
				end.should change(User, :count).by(1)
			end
		end

	  describe "GET 'edit'" do
	    it "should be successful" do
	      get 'edit', :id => 1
	      response.should be_success
	    end
	  end

		describe "PUT 'update'" do
			before(:each) do
			  @user_to_update = User.create!(:name => 'updated test user', :email => 'test@test.com', :password => 'secret', :password_confirmation => 'secret' )
			end
			it "should create a new user" do
				new_name = 'updated test user'
				put 'update',  :id => @user_to_update.id, :user => {:name => new_name, :email => 'test@test.com', :password => 'secret', :password_confirmation => 'secret' }
				assigns[:user].name.should == new_name
			end
			
			it "should be able to set ALL attributes" do
				put 'update',  :id => @user_to_update.id, :user => { :id => @user_to_update.id, :name => 'updated test user', :email => 'test@test.com', :password => 'secret', :password_confirmation => 'secret', :roles => ['admin','author'] }
				assigns[:user].roles.should == ['admin','author']
			end
		end

	  describe "GET 'destroy'" do
			before(:each) do
			  @delete_user = Factory(:user, :name => 'to_be_deleted', :email => 'deleted@test.com')
			end
			
	    it "should redirect to the user list" do
	      delete 'destroy', :id => @delete_user.id
	      response.should redirect_to admin_users_path
	    end
	
			it "should destroy te user" do
				delete 'destroy', :id => @delete_user.id
				User.exists?(@delete_user.id).should be_false
			end
	  end
	end

	describe "as an registered user" do
		before(:each) do
		  @user = Factory :user
			sign_in @user
		end

	  describe "GET 'index'" do
	    it "should be redirect_to root_path" do
	      get 'index'
	      response.should redirect_to root_path
	    end
	  end

	  describe "GET 'show'" do
	    it "should be redirect_to root_path" do
	      get 'show', :id => 1
	      response.should redirect_to root_path
	    end
	  end

	  describe "GET 'new'" do
	    it "should be redirect_to root_path" do
	      get 'new'
	      response.should redirect_to root_path
	    end
	  end
	
		describe "POST 'create'" do
		  it "should redirect to the root path" do
		    post 'create', :user => {:name => 'test'}
				response.should redirect_to root_path
		  end
		end

	  describe "GET 'edit'" do
	    it "should be redirect_to root_path" do
	      get 'edit', :id => 1
	      response.should redirect_to root_path
	    end
	  end

	  describe "GET 'destroy'" do
	    it "should be redirect_to root_path" do
	      delete 'destroy', :id => 1
	      response.should redirect_to root_path
	    end
	  end
	end

	describe "as a guest" do

	  describe "GET 'index'" do
	    it "should deny access" do
	      get 'index'
	      response.should redirect_to sign_in_path
	    end
	  end

	  describe "GET 'show'" do
	    it "should deny access" do
	      get 'show', :id => 1
	      response.should redirect_to sign_in_path
	    end
	  end

	  describe "GET 'new'" do
	    it "should deny access" do
	      get 'new'
	      response.should redirect_to sign_in_path
	    end
	  end
	
		describe "POST 'create'" do
		  it "should deny access" do
		    post 'create', :user => {:name => 'test'}
				response.should redirect_to sign_in_path
		  end
		end

	  describe "GET 'edit'" do
	    it "should deny access" do
	      get 'edit', :id => 1
	      response.should redirect_to sign_in_path
	    end
	  end

	  describe "GET 'destroy'" do
	    it "should deny access" do
	      delete 'destroy', :id => 1
	      response.should redirect_to sign_in_path
	    end
	  end
	end


end
