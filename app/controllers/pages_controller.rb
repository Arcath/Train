class PagesController < ApplicationController
	filter_resource_access
	def index
		@pages = Page.all
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new
	end

	def edit
		@page = Page.find(params[:id])
	end

	def create
		@page = Page.new(params[:page])
		if @page.save
			flash[:notice] = 'Page was successfully created.'
			redirect_to(@page)
		else
			render :action => "new"
		end
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			flash[:notice] = 'Page was successfully updated.'
			redirect_to(@page)
		else
			render :action => "edit"
		end
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy
		redirect_to(pages_url)
	end
end
