class Page < ActiveRecord::Base
	liquid_methods :name, :findpages, :id
	
	def findpages(con, order = nil)
		Page.find(:all, :conditions => con, :order => order)
	end
end
