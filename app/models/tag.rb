class Tag < ActiveRecord::Base
	attr_accessible :name
	
	has_many :tagments
	has_many :posts, :through => :tagments
end
