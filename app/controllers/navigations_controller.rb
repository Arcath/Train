class NavigationsController < ApplicationController
	filter_resource_access
	def index
		@navigations = Navigation.all
	end
	
	def permalink
		@nav=Navigation.find_by_permalink(params[:permalink])
		redirect_to :controller => @nav.destination_controller, :action => @nav.destination_action, :id => @nav.destination_id
	end

	def show
		@navigation = Navigation.find(params[:id])
	end
	
	def new
		@navigation = Navigation.new
	end

	def edit
		@navigation = Navigation.find(params[:id])
	end

	def create
		@navigation = Navigation.new(params[:navigation])
		if @navigation.save
			flash[:notice] = 'Navigation was successfully created.'
			redirect_to(@navigation)
		else
			render :action => "new"
		end
	end

	def update
		@navigation = Navigation.find(params[:id])
		if @navigation.update_attributes(params[:navigation])
			flash[:notice] = 'Navigation was successfully updated.'
			redirect_to(@navigation)
		else
			format.html { render :action => "edit" }
		end
	end

	def destroy
		@navigation = Navigation.find(params[:id])
		@navigation.destroy
		redirect_to(navigations_url)
	end
end
