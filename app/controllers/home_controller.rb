class HomeController < ApplicationController
	filter_resource_access
	def index
		@posts=Post.homepage(params[:page])
	end
end
