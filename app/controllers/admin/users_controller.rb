class Admin::UsersController < Admin::AdminController
	load_resource :except => :index
	
  def index
		@users = User.order(:name).paginate(:page => params[:page])
  end

  def show
  end

  def new
  end

	def create
		@user.update_attributes(params[:user], :as => :admin)
		if @user.save
			sign_in @user
			flash[:success] = "New user added!"
			redirect_to admin_user_path @user
		else
			flash.now[:error] = "Oops! There was an error saving this user."
			render 'new'
		end
	end

  def edit
  end

	def update
		if @user.update_attributes(params[:user], :as => :admin)
			flash[:success] = "Profile updated."
			redirect_to admin_user_path @user
		else
			flash.now[:error] = "Oops! There was an error updating this profile."
			render 'edit'
		end
	end

  def destroy
		@user.destroy
		Rails.logger.debug @user.errors.messages
		redirect_to admin_users_path
  end

	def ban
		@user = User.find(params[:id])
		if @user.has_role? 'banned'
			@user.roles = @user.roles.reject {|r| r == 'banned'}
			flash[:notice] = "User #{@user.name} has been unbanned."
		else
			@user.roles += ['banned']
			flash[:notice] = "User #{@user.name} has been banned."
		end
		@user.save!
		redirect_to :back
	end

end
