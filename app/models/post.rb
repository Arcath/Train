class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :forum
	belongs_to :user
	
	def postable
		return true
	end
	def modable
		return true
	end
	def self.homepage(page)
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
		postids=""
		@topics.each do |topic|
			if postids == "" then
				postids="id = #{topic.firstpost_id}"
			else
				postids+=" OR id = #{topic.firstpost_id}"
			end
		end
		paginate(:page => page, :per_page => 10, :conditions => postids, :order => "created_at DESC")
	end
end
