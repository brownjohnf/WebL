class CommentsController < ApplicationController
  load_and_authorize_resource :post
  load_and_authorize_resource :comment, :through => :post

	def index
	end

  def show
  end

  def new
  end

  def create
    if @comment.save
      redirect_to @post, :notice => "Successfully created comment."
    else
      flash[:error] = "Comment could not be saved"
			redirect_to @post
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      redirect_to @post, :notice  => "Successfully updated comment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, :notice => "Successfully destroyed comment."
  end
end
