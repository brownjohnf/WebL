class Post < ActiveRecord::Base
  attr_accessible :title, :content, 
									:publication_date, :published, :comments_disabled,
									:tags_attributes, :tag_tokens

	validates	:title,				:presence => :true,
													:length => {:within => 3..60}
	validates :content,			:presence => :true
	validates :user_id,			:presence => :true 
	validates :publication_date, :presence => :true
	
	belongs_to :user
	
	default_scope order('publication_date DESC').includes(:tags).includes(:user)
	scope :published, where(:published => true)
	
	has_many :comments, :dependent => :destroy
	has_many :tagments
	has_many :tags, :through => :tagments
	
	def to_param
		"#{id}-#{title.parameterize}"
	end
	
	def tag_tokens
		@tag_tokens = []
		self.tags.each do |tag|
			@tag_tokens << {:id => tag.id, :name => tag.name.humanize}
		end
		@tag_tokens
	end

	def tag_tokens=(ids)
		ids.gsub!(/CREATE_TAG_(.+?)_END/) do
		  Tag.create!(:name => $1.humanize).id
		end
		self.tag_ids = ids.split(",")
	end
end 
