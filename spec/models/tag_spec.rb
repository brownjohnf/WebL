require 'spec_helper'

describe Tag do
	it "should require a name" do
	  @tag = Tag.new
		@tag.should_not be_valid
	end
	
	it "should be created with a valid name" do
	  @tag = Tag.new(name:'testtag')
		@tag.should be_valid
	end
	
	it "should require a unique name" do
	  @tag1 = Tag.new(name:'testtag')
		@tag1.save
		@tag2 = Tag.new(name:'testtag')
		@tag2.should_not be_valid
	end
end
