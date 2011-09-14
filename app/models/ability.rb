class Ability
  include CanCan::Ability

  def initialize(user)
		@user = user
		user ||= User.new # guest user (not logged in)

		can :show, User
		can [:read, :search], Post, :published => true
		cannot [:read, :search], Post, ["publication_date > ?", Time.now] do |post|
			post.publication_date > Time.now
		end
		can :read, Comment
		
		@user.nil? ? guest_roles : registered_roles
		author_roles if user.has_role? 'author'
		admin_roles if user.has_role? 'admin'
		cannot :create, Comment, :post => {:comments_disabled => true}
		banned_roles if user.has_role? 'banned'
  end

	def guest_roles
		can :create, User
	end
	
	def registered_roles
		can :create, Comment, :user_id => @user.id
		can :update, Comment do |comment|  
			comment.try(:user) == user  
		end
		can :read, User
		can :update, User do |user|
			user == @user
		end
	end
	
	def author_roles
		can :create, Post
		can :read, Post, :published => false, :user_id => @user.id
		can [:update, :destroy], Post do |post|
			post.try(:user) == @user
		end
		can :manage, Comment, :post => { :user_id => @user.id }
	end
	
	def admin_roles
		can :manage, :all
	end
	
	def banned_roles
		cannot :manage, :all
	end
end