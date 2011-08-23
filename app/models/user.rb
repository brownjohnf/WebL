class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	attr_accessible :name, :email, :password, :password_confirmation, :roles, :as => :admin
	has_secure_password
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	ROLES = %w[admin author banned] # position in this list should NEVER change

	validates :name,  		:presence 	=> true,
												:length   	=> { :within => 4..20 },
												:uniqueness => { :case_sensitive => false }
	validates :email,			:presence		=> true,
												:length			=> { :within => 6..60 },
												:uniqueness => { :case_sensitive => false },
												:format			=> { :with => email_regex }
	validates :password, 	:presence		=> true,
												:on					=> :create
												
	before_save :generate_salt
	before_destroy :update_authored_articles
	
	has_many :posts
	has_many :comments, :dependent => :destroy
	
	def to_param
		"#{id}-#{name.parameterize}"
	end
	
  def self.authenticate_with_cookie(id, cookie_salt)
		user = find_by_id(id)
		(user && user.cookie_hash == cookie_salt) ? user : nil
 	end
	
	def roles=(roles)
		self.roles_mask = (roles & ROLES).map { |r| 2**(ROLES.index(r)) }.sum
	end

	def roles
		ROLES.reject do |r|
			((roles_mask || 0) & 2**ROLES.index(r)).zero?
		end
	end
	
	def has_role?(role)
	  roles.include?(role.to_s)
	end
	
	
	private
		def generate_salt
			if new_record? 
				self.cookie_hash = BCrypt::Password.create("#{Time.now.utc}--#{password_digest}--#{rand}")
			end
		end
		
		def update_authored_articles
			# This method takes all the authored articles and updates them to a special 'deleted' user
			# the special 'deleted' user is created if necessary
			# to make sure that nobody registeres this name to steal articles, the user status is set to banned just to be sure
			random_pass = "#{Time.now.utc}--#{rand}"
			deleted_author = User.find_or_create_by_name(:name => "Non existing user", :password => random_pass, :password_confirmation => random_pass, :email => APP_CONFIG[:deleted_user_email])
			deleted_author.roles = ['banned']
			deleted_author.save
			posts.each do |post|
				post.user = deleted_author
				post.save
			end
		end
end
