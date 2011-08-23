require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::CommentsController do
  fixtures :all
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
	
	describe "edit" do
	  it "should be successful" do
	    get :edit, :id => Comment.first
	  end
	end
	
	describe "update" do
		before(:each) do
		  @user1 = Factory(:user, :name => "test1", :email => "test1@example.com")
			@user2 = Factory(:user, :name => "test2", :email => "test2@example.com")
			@post1 = Post.first
			@post2 = Post.last
			@comment = @post1.comments.new(:content => "initial content")
			@comment.user = @user1
			@comment.save
		end
		
	  it "should work with correct parameters" do
			put 'update', :id => @comment.id, :comment => {:content => "new content"}
			assigns[:comment].content.should == "new content"
			put 'update', :id => @comment.id, :comment => {:user_id => @user2.id}
			assigns[:comment].user.should == @user2
			put 'update', :id => @comment.id, :comment => {:post_id => @post2.id}
			assigns[:comment].post.should == @post2
		end
		
		it "should refuse non existing user ids" do
		  put 'update', :id => @comment.id, :comment => {:user_id => 120}
			@comment.reload
			@comment.user.should_not be_nil
 			@comment.user.should == @user1
		end
		
		it "should refuse non existing post ids" do
		  put 'update', :id => @comment.id, :comment => {:post_id => 120}
			@comment.reload
			@comment.post.should_not be_nil
 			@comment.post.should == @post1
		end
	end
	
	describe "destroy" do
	  it "destroy action should destroy model and redirect to index action" do
	    comment = Comment.first
	    delete :destroy, :id => comment
	    response.should redirect_to(admin_comments_path)
	    Comment.exists?(comment.id).should be_false
	  end
	end
end