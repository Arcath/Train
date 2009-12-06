class Topic < ActiveRecord::Base
	belongs_to :forum
	has_many :posts
	attr_accessor :post_body
	
	def topicable
		return true
	end
end
