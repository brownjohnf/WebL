class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	# TODO: add dynamic attr_accessible
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
	
	has_many :posts
	
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
end
