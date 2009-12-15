class PlanetsController < ApplicationController
	filter_resource_access
  
	def index
		@planets = Planet.all(:limit => 10, :order => "published_at desc")
		@feeds = PlanetFeed.all
		@feeds.each do |feed|
			if feed.updated_at <= (Time.now - 120.minutes) or feed.created_at >= (Time.now - 120.minutes) then
				Planet.update_from_feed(feed.url)
			end
		end
	end

	def show
		@planet = Planet.find(params[:id])
	end
	
	def new
		@planet = Planet.new
	end

	def edit
		@planet = Planet.find(params[:id])
	end

	def create
		@planet = Planet.new(params[:planet])
		if @planet.save
			flash[:notice] = 'Planet was successfully created.'
			redirect_to(@planet)
		else
			render :action => "new"
      		end
	end

	def update
		@planet = Planet.find(params[:id])
		if @planet.update_attributes(params[:planet])
			flash[:notice] = 'Planet was successfully updated.'
			redirect_to(@planet)
      		else
      			render :action => "edit"
		end
	end

	def destroy
		@planet = Planet.find(params[:id])
		@planet.destroy
		redirect_to(planets_url)
	end
end
