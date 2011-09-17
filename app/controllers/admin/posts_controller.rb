class Admin::PostsController < Admin::AdminController

  def index
		@posts = Post.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
		@post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_url, :notice => "Successfully destroyed post."
  end

end
