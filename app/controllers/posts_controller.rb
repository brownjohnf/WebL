class PostsController < ApplicationController
	before_filter :find_posts, :only => :index
	before_filter :find_user_posts, :only => :user_index
	before_filter :new_post, :only => [:new, :create]
	load_and_authorize_resource

  def index
		if params[:user_id] && (current_user == User.find_by_id(params[:user_id]))
			@posts = Post.where(:user_id => params[:user_id])
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
		
		def find_posts
			@posts = Post.where(:published => true)
		end
		
		def find_user_posts
			@posts = Post.where(:user_id => current_user)
		end
end
