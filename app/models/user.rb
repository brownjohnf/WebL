class User < ActiveRecord::Base
	has_secure_password
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name,  	:presence 	=> true,
											:length   	=> { :within => 4..20 },
											:uniqueness => { :case_sensitive => false }
	validates :email,		:presence		=> true,
											:length			=> { :within => 6..60 },
											:uniqueness => { :case_sensitive => false },
											:format			=> { :with => email_regex }
	validates :password, :presence	=> true
end
