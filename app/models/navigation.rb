class Navigation < ActiveRecord::Base
	def toplayer
		self.find_by_parent(0)
	end
end
