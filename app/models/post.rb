class Post < ActiveRecord::Base
  attr_accessible :title, :content, :publication_date, :published

	validates	:title,				:presence => :true,
													:length => {:within => 3..60}

	validates :content,			:presence => :true
	validates :user_id,			:presence => :true 
	
	belongs_to :user
end 
