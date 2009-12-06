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
end
