class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  	:presence 	=> true,
											:length   	=> { :within => 4..20 },
											:uniqueness => { :case_sensitive => false }
	validates :email,		:presence		=> true,
											:length			=> { :within => 6..60 },
											:uniqueness => { :case_sensitive => false },
											:format			=> { :with => email_regex }
	validates :password, 	:presence	=> true,
												:on				=> :create
												
	before_save :generate_salt
	
  def self.authenticate_with_cookie(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
  end
	
	private
		def generate_salt
			if new_record? 
				self.cookie_hash = BCrypt::Password.create("#{Time.now.utc}--#{password_digest}--#{rand}")
			end
		end
end
