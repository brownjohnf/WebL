class PostsController < ApplicationController
	before_filter :new_post, :only => [:new, :create]
	load_and_authorize_resource

  def index
		if params[:user_id]
			@posts = Post.accessible_by(current_ability).where(:user_id => params[:user_id]).paginate(:page => params[:page])
		else
			@posts = Post.accessible_by(current_ability).published.paginate(:page => params[:page], :per_page => 3)
		end
  end

	def search
		if params[:q]
			@posts = Post.accessible_by(current_ability).where('title LIKE :title', :title => "%#{params[:q]}%").paginate(:page => params[:page])
		else
			@posts = Post.accessible_by(current_ability).paginate(:page => params[:page])
		end
		render 'index'
	end

  def show
		@comments = @post.comments.includes(:user).order("created_at asc").paginate(:page => params[:page])
  end

  def new
		@post.publication_date = Time.zone.now
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
