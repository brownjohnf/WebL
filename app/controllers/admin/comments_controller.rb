class Admin::CommentsController < Admin::AdminController
	load_resource
	
  def index
  end

  def edit
  end

	def update
		if @comment.update_attributes(params[:comment], :as => :admin)
			flash[:success] = "Comment updated."
			redirect_to admin_comments_path
		else
			flash.now[:error] = "Oops! There was an error updating this comment."
			render 'edit'
		end
	end

  def destroy
		@comment.destroy
		redirect_to admin_comments_path
  end

end
