require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
	before(:each) do
	  @attr = { :content => "dummy content"}
		@user = Factory :user
		@post = Factory :post, :user_id => @user.id
	end
	
  it "should not be valid without attributes" do
    Comment.new.should_not be_valid
  end
	
	it "should not be valid without a user and post" do
		Comment.new(@attr).should_not be_valid
		no_user_comment = @post.comments.new(@attr).should_not be_valid
		no_post_comment = @user.comments.new(@attr).should_not be_valid
	end
	
	it "should be valid with a content, user and post" do
		good_comment = @post.comments.new(@attr)
		good_comment.user = @user
		good_comment.post = @post
		good_comment.should be_valid
	end

end
