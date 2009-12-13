class PlanetFeedsController < ApplicationController
	filter_resource_access
	def index
		@planet_feeds = PlanetFeed.all
	end

	def show
		@planet_feed = PlanetFeed.find(params[:id])
	end

	def new
		@planet_feed = PlanetFeed.new
	end

	def edit
		@planet_feed = PlanetFeed.find(params[:id])
	end

	def create
		@planet_feed = PlanetFeed.new(params[:planet_feed])

		if @planet_feed.save
			flash[:notice] = 'PlanetFeed was successfully created.'
			redirect_to(@planet_feed)
		else
			render :action => "new"
    		end
  	end

	def update
		@planet_feed = PlanetFeed.find(params[:id])
		
		if @planet_feed.update_attributes(params[:planet_feed])
			flash[:notice] = 'PlanetFeed was successfully updated.'
			redirect_to(@planet_feed)
		else
			render :action => "edit"
    		end
  	end

	def destroy
		@planet_feed = PlanetFeed.find(params[:id])
		@planet_feed.destroy
		redirect_to(planet_feeds_url) 
    	end
end
