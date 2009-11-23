class SystemsController < ApplicationController
	filter_resource_access

  	def index
  		@systems = System.all
  		flash[:notice]="The Ability to edit variable names, and to destroy variables are given for developers to add to system table"
	end

	def show
		@system = System.find(params[:id])
	end

	def new
		@system = System.new
	end

	def edit
		@system = System.find(params[:id])
	end

	def create
		@system = System.new(params[:system])
		if @system.save
			flash[:notice] = 'System was successfully created.'
			redirect_to(@system)
		else
			render :action => "new"
		end
	end

	def update
		@system = System.find(params[:id])
		if @system.update_attributes(params[:system])
			flash[:notice] = 'System was successfully updated.'
			redirect_to(@system)
		else
			 render :action => "edit"
		end
	end

	def destroy
		@system = System.find(params[:id])
		@system.destroy
		redirect_to(systems_url)
	end
end
