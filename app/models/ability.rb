class Ability
  include CanCan::Ability

  def initialize(user)
		@user = user
		user ||= User.new # guest user (not logged in)

		#can :read, Post
		can :show, User
		guest_roles if @user.nil?
		registered_roles unless @user.nil?		
		author_roles if user.has_role? 'author'
		admin_roles if user.has_role? 'admin'
		banned_roles if user.has_role? 'banned'
  end

	def guest_roles
		can :create, User
	end
	
	def registered_roles
		#can :create, Comment
		#can :update, Comment do |comment|  
		#	comment.try(:user) == user  
		#end
		can :read, User
		can :update, User do |user|
			user == @user
		end
	end
	
	def author_roles
		#can :create, Post
		#can [:update, :destroy], Post do |post|
		#	post.try(:user) == user
		#end
	end
	
	def admin_roles
		can :manage, :all
	end
	
	def banned_roles
		cannot :manage, :all
	end
end