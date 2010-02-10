class HomeController < ApplicationController
	filter_resource_access
	def index
		@template_format = "html"
		@posts=Post.homepage(params[:page])
		@rssposts=Post.homepage(1)
	end
end
