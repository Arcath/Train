class ForumsController < ApplicationController
	filter_resource_access
	def index
		@forum = Forum.parent_equals(nil).previous_equals(nil).first
	end

	def show
		@forum = Forum.find(params[:id])
		session[:forum_id]=@forum.id
		session[:topic_id]=nil
	end
	
	def new
		@forum = Forum.new
	end

	def edit
		@forum = Forum.find(params[:id])
	end

	def create
		@forum = Forum.new(params[:forum])
		if @forum.save
			flash[:notice] = 'Forum was successfully created.'
			redirect_to(@forum)
		else
			render :action => "new"
		end
	end
	
	def update
		@forum = Forum.find(params[:id])
		if @forum.update_attributes(params[:forum])
			flash[:notice] = 'Forum was successfully updated.'
			redirect_to(@forum)
		else
			render :action => "edit"
		end
	end

	def destroy
		@forum = Forum.find(params[:id])
		@forum.destroy
		redirect_to(forums_url)
	end
end
