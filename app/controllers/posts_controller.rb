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
		render 'index'
	end

  def show
  end

  def new
		@post.publication_date = Time.current
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
		store_referer
  end

  def update
    if @post.update_attributes(params[:post])
			flash[:notice] = "Successfully updated post."
      redirect_back_or @post
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
