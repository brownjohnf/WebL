class Tag < ActiveRecord::Base
	attr_accessible :name
	
	has_many :tagments, :dependent => :destroy
	has_many :posts, :through => :tagments
	
	validates :name, :presence => :true,
									 :uniqueness => :true
end
