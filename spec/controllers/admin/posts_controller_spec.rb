require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::PostsController do
  fixtures :posts
	before(:each) do
	  @admin_user = Factory(:user, :roles => ['admin'])
		sign_in @admin_user
	end
	
	describe "index" do
	  it "should be successful" do
	    get :index
			response.should be_successful
	  end
	end
	
	describe "destroy" do
	  it "destroy action should destroy model and redirect to index action" do
	    post = Post.first
	    delete :destroy, :id => post
	    response.should redirect_to(admin_posts_url)
	    Post.exists?(post.id).should be_false
	  end
	end
end