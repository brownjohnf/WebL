class PostsController < ApplicationController
	before_filter :new_post, :only => [:new, :create]
	load_and_authorize_resource

  def index
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
