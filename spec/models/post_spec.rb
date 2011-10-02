require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
	before(:each) do
		@attr = {:title => "test title", :content => "Test content of the first post", :published => false, :publication_date => Time.now}
		@user = Factory(:user)
	end
	
	it "should create a new post with valid attributes" do
		@user.posts.create(@attr).should be_valid 
	end
	
	it "should validate the presence of a title" do
		@user.posts.create(@attr.merge(:title => "")).should_not be_valid
	end
	
	it "should validate the presence of content" do
	  @user.posts.create(@attr.merge(:content => "")).should_not be_valid
	end
	
	it "should validate that it is connected to a user" do
	  Post.create(@attr).should_not be_valid
	end
	
	it "should disconnect any tags when being destroyed" do
	  @post = @user.posts.create!(@attr)
		@tag = Tag.create!(:name => "test")
		@post.tags << @tag
		@post.save
		@post.destroy
		@tag.posts.count.should == 0
	end
end
