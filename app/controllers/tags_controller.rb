class TagsController < ApplicationController
	load_and_authorize_resource :except => :index
	
	def index
		@tags = Tag.accessible_by(current_ability).where('name LIKE :q', :q => "%#{params[:q]}%")
		authorize! :index, Tag
		respond_to do |format|
			format.json { render :json => @tags}
		end
	end
	
	def show
		
	end
end

