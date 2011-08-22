# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  username            :string(255)
#  password_digest     :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  email               :string(255)
#  salt                :string(255)
#  admin               :boolean         default(FALSE)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  ivector             :string(255)
#  gcal_username       :string(255)
#  gcal_password       :string(255)
#

require 'spec_helper'

describe User do

	describe "When creating a new user" do
	  before(:each) do
	    @attr = {
	      :name => "George Clooney", 
	      :email => "g.clooney@example.com", 
	      :password => "secret",
	      :password_confirmation => "secret"
	      }
	  end
  
	  it "Should create a new instance given valid attributes" do
	    User.create!(@attr).should be_valid
	  end

		it "Should validate the confirmation password" do
		  User.new(@attr.merge(:password_confirmation => "wrongpass")).should_not be_valid
		end
	
		it "should check for presence and lenght of a username" do
			User.new(@attr.merge(:name => "")).should be_invalid
		  User.new(@attr.merge(:name => "a")).should be_invalid
			User.new(@attr.merge(:name => "abc")).should be_invalid
			User.new(@attr.merge(:name => "abcd")).should be_valid
			User.new(@attr.merge(:name => "aaaaabbbcccddd")).should be_valid
			User.new(@attr.merge(:name => "aaaaabbbbbcccccddddd")).should be_valid
			User.new(@attr.merge(:name => "a"*21)).should be_invalid
		end
	
		it "should check for presence and format of the email" do
			User.new(@attr.merge(:email => "")).should be_invalid
			User.new(@attr.merge(:email => "hallo")).should be_invalid
			User.new(@attr.merge(:email => "test@test")).should be_invalid
			User.new(@attr.merge(:email => "@test.com")).should be_invalid
			User.new(@attr.merge(:email => "user@test.com")).should be_valid
			User.new(@attr.merge(:email => "g.clooney@test.jp")).should be_valid
			User.new(@attr.merge(:email => "a.j.h.klnt@test.co.uk")).should be_valid
		end
		
		it "should check for the presence of a password" do
		  User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
		end
	end

	it "should have a logical url" do
    @attr = {
      :name => "George Clooney", 
      :email => "g.clooney@example.com", 
      :password => "secret",
      :password_confirmation => "secret"
      }
		@user = User.new(@attr)
		@user.id = 105
		@user.to_param.should == "#{@user.id}-#{@user.name.parameterize}"
	end
end


























