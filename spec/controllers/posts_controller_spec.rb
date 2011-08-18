require File.dirname(__FILE__) + '/../spec_helper'

describe PostsController do
  fixtures :posts
  render_views
	describe "as an admin" do
		
		before(:each) do
		  @admin = Factory(:user)
			@admin.roles = ['admin'] 
			sign_in @admin
		end
		
	  it "index action should render index template" do
	    get :index
	    response.should render_template(:index)
	  end

	  it "show action should render show template" do
	    get :show, :id => Post.first
	    response.should render_template(:show)
	  end

	  it "new action should render new template" do
	    get :new
	    response.should render_template(:new)
	  end

	  it "create action should render new template when model is invalid" do
	    Post.any_instance.stubs(:valid?).returns(false)
	    post :create
	    response.should render_template(:new)
	  end

	  it "create action should redirect when model is valid" do
	    Post.any_instance.stubs(:valid?).returns(true)
	    post :create
	    response.should redirect_to(post_url(assigns[:post]))
	  end

	  it "edit action should render edit template" do
	    get :edit, :id => Post.first
	    response.should render_template(:edit)
	  end

	  it "update action should render edit template when model is invalid" do
	    Post.any_instance.stubs(:valid?).returns(false)
	    put :update, :id => Post.first
	    response.should render_template(:edit)
	  end

	  it "update action should redirect when model is valid" do
	    Post.any_instance.stubs(:valid?).returns(true)
	    put :update, :id => Post.first
	    response.should redirect_to(post_url(assigns[:post]))
	  end

	  it "destroy action should destroy model and redirect to index action" do
	    post = Post.first
	    delete :destroy, :id => post
	    response.should redirect_to(posts_url)
	    Post.exists?(post.id).should be_false
	  end	  
	end

	describe "as a registered user" do
		
		before(:each) do
		  @user = Factory(:user)
			sign_in @user
		end
		
	  it "index action should render index template" do
	    get :index
	    response.should render_template(:index)
	  end

	  it "show action should render show template" do
	    get :show, :id => Post.first
	    response.should render_template(:show)
	  end

	  it "new action should deny access" do
	    get :new
	    response.should redirect_to root_path
			flash[:error].should =~ /access denied/i
	  end

	  it "create action should deny access and not store the post" do
	    Post.any_instance.stubs(:valid?).returns(true)
			lambda do
	    	post :create
				response.should redirect_to root_path
			end.should change(Post, :count).by(0)
			flash[:error].should =~ /access denied/i
	  end

	  it "edit action should deny access" do
	    get :edit, :id => Post.first
	    response.should redirect_to root_path
			flash[:error].should =~ /access denied/i
	  end

	  it "update action should deny access" do
	    Post.any_instance.stubs(:valid?).returns(true)
	    put :update, :id => Post.first
			response.should redirect_to root_path
			flash[:error].should =~ /access denied/i
	  end

	  it "destroy action should destroy model and redirect to index action" do
	    post = Post.first
	    delete :destroy, :id => post
	    response.should redirect_to root_path
			flash[:error].should =~ /access denied/i
	    Post.exists?(post.id).should be_true
	  end	  
	end

	describe "as an author" do
		
		before(:each) do
		  @author = Factory(:user)
			@author.roles = ['author'] 
			sign_in @author
		end
		
	  it "index action should render index template" do
	    get :index
	    response.should render_template(:index)
	  end

	  it "show action should render show template" do
	    get :show, :id => Post.first
	    response.should render_template(:show)
	  end

	  it "new action should render new template" do
	    get :new
	    response.should render_template(:new)
	  end

	  it "create action should render new template when model is invalid" do
	    Post.any_instance.stubs(:valid?).returns(false)
	    post :create
	    response.should render_template(:new)
	  end

	  it "create action should redirect when model is valid" do
	    Post.any_instance.stubs(:valid?).returns(true)
	    post :create
	    response.should redirect_to(post_url(assigns[:post]))
	  end

	  it "edit action should render edit template for an owned post" do
			@author.posts = [Post.first]
	    get :edit, :id => Post.first
	    response.should render_template(:edit)
	  end

	  it "edit action should deny access for non owned posts" do
			@author.posts = [Post.first]
	    get :edit, :id => Post.last
	    response.should redirect_to root_path
			flash[:error].should =~ /access denied/i
	  end

	  it "update action should render edit template when model is invalid" do
	    Post.any_instance.stubs(:valid?).returns(false)
	    put :update, :id => Post.first
	    response.should render_template(:edit)
	  end

	  it "update action should redirect when model is valid" do
	    Post.any_instance.stubs(:valid?).returns(true)
	    put :update, :id => Post.first
	    response.should redirect_to(post_url(assigns[:post]))
	  end

	  it "destroy action should destroy model and redirect to index action" do
	    post = Post.first
	    delete :destroy, :id => post
	    response.should redirect_to(posts_url)
	    Post.exists?(post.id).should be_false
	  end	  
	end
 

end
