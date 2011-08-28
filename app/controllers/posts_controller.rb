class PostsController < ApplicationController
	before_filter :new_post, :only => [:new, :create]
	load_and_authorize_resource

  def index
		if params[:user_id]
			@posts = Post.accessible_by(current_ability).where(:user_id => params[:user_id])
		else
			@posts = Post.accessible_by(current_ability).published.limit(3)
		end
  end

	def search
		if params[:q]
			@posts = Post.accessible_by(current_ability).where('title LIKE :title', :title => "%#{params[:q]}%")
		else
			@posts = Post.accessible_by(current_ability)
		end
	end

  def show
  end

  def new
  end

  def create
		@post.update_attributes(params[:post])
    if @post.save
      redirect_to @post, :notice => "Successfully created post."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end

	private
		def new_post
			@post = current_user.posts.new
		end
end
