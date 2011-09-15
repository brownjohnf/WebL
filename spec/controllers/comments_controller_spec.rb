require File.dirname(__FILE__) + '/../spec_helper'

describe CommentsController do
  fixtures :all
  render_views
	
	before(:each) do
		@user = Factory(:user)
		@user.roles = ['admin']
		sign_in @user
	  @post = Post.new(:title => "test", :content => "test content", :publication_date => Time.now )
		@post.user = @user
		@post.id = 1
		@post.save!
	end

  it "create action should redirect back to a post when model is invalid" do
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :post_id => @post.id
    response.should redirect_to @post
  end

  it "create action should redirect when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create, :post_id => @post.id
    response.should redirect_to(@post)
  end

  it "edit action should render edit template" do
    get :edit, :id => Comment.first, :post_id => @post.id
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Comment.first, :post_id => @post.id
    response.should render_template(:edit)
  end

  it "update action should redirect to post when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Comment.first, :post_id => @post.id
    response.should redirect_to(@post)
  end

  it "destroy action should destroy model and redirect to index action" do
    comment = Comment.first
    delete :destroy, :id => comment, :post_id => @post.id
    response.should redirect_to(@post)
    Comment.exists?(comment.id).should be_false
  end
end
