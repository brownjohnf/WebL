class TagsController < ApplicationController
	load_and_authorize_resource :except => :index
	
	def index
		@tags = Tag.accessible_by(current_ability).where('name LIKE :q', :q => "%#{params[:q]}%")
		authorize! :index, Tag
		@tag_tokens = []
		@tag_tokens << {:id => "CREATE_TAG_#{params[:q]}_END", :name => "Create #{params[:q].humanize}"} unless (@tags.any? && @tags.first.name.humanize == params[:q].humanize)
		@tags.each { |tag| @tag_tokens << {:id => tag.id, :name => tag.name.humanize} }
		respond_to do |format|
			format.json do
				render :text => @tag_tokens.to_json
			end
		end
	end
	
	def show
		@posts = @tag.posts.accessible_by(current_ability).published.paginate(:page => params[:page], :per_page => 3)
	end
end

