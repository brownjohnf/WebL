class Admin::PostsController < Admin::AdminController

  def index
		@posts = Post.all
  end

  def destroy
		@post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_url, :notice => "Successfully destroyed post."
  end

end
