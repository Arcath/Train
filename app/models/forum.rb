class Forum < ActiveRecord::Base
	has_many :topics
	has_many :posts
	
	def canposts=(canposts)
		self.canposts_mask = (canposts & User::ROLES).map { |r| 2**User::ROLES.index(r) }.sum
	end
	
	def canposts
		User::ROLES.reject { |r| ((canposts_mask || 0) & 2**User::ROLES.index(r)).zero? }
	end
	def cantopics=(cantopics)
		self.cantopics_mask = (cantopics & User::ROLES).map { |r| 2**User::ROLES.index(r) }.sum
	end
	
	def cantopics
		User::ROLES.reject { |r| ((cantopics_mask || 0) & 2**User::ROLES.index(r)).zero? }
	end
	def canviews=(canviews)
		self.canviews_mask = (canviews & User::ROLES).map { |r| 2**User::ROLES.index(r) }.sum
	end
	def canviews
		User::ROLES.reject { |r| ((canviews_mask || 0) & 2**User::ROLES.index(r)).zero? }
	end
	def canmoderates=(canmoderates)
		self.canmoderates_mask = (canmoderates & User::ROLES).map { |r| 2**User::ROLES.index(r) }.sum
	end
	def canmoderates
		User::ROLES.reject { |r| ((canmoderates_mask || 0) & 2**User::ROLES.index(r)).zero? }
	end
end
