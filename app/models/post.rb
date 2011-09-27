class Post < ActiveRecord::Base
  attr_accessible :title, :content, 
									:publication_date, :published, :comments_disabled,
									:tags_attributes, :tags

	validates	:title,				:presence => :true,
													:length => {:within => 3..60}
	validates :content,			:presence => :true
	validates :user_id,			:presence => :true 
	validates :publication_date, :presence => :true
	
	belongs_to :user
	
	default_scope order('publication_date DESC')
	scope :published, where(:published => true)
	
	has_many :comments, :dependent => :destroy
	has_many :tagments
	has_many :tags, :through => :tagments
	
	def to_param
		"#{id}-#{title.parameterize}"
	end
end 
