class HomeController < ApplicationController
	filter_resource_access
	def index
		conditions=""
		@forum=Forum.find(:all, :conditions => "frontpage = 1")
		@forum.each do |forum|
			if conditions == "" then
				conditions="forum_id = #{forum.id}"
			else
				conditions+=" OR forum_id = #{forum.id}"
			end
		end
		@topics=Topic.find(:all, :conditions => conditions, :limit => 10, :order => "created_at DESC")
		@posts=[]
		@topics.each do |topic|
			@posts.push(Post.find(topic.firstpost_id))
		end
	end
end
