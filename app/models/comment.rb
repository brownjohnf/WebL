class Comment < ActiveRecord::Base
  attr_accessible :content
  attr_accessible :content, :user_id, :post_id, :as => :admin

	default_scope includes(:user)

	validates :content, :presence => true
	validates :user_id, :post_id, :presence => true
	validate :user_id_should_be_valid, :post_id_should_be_valid

	belongs_to :post, :counter_cache => true
	belongs_to :user
	
	private 
	
		def user_id_should_be_valid
			errors.add(:user_id, "should be a valid user") if user.nil?
		end
	
		def post_id_should_be_valid
			errors.add(:post_id, "should be a valid post") if post.nil?
		end
end
