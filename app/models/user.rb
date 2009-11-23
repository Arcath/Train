class User < ActiveRecord::Base
	acts_as_authentic
	
	ROLES = %w[admin moderator author content_writer member banned]
	
	def role_symbols
		if role == nil then
			self.role="member"
		end
		[self.role.to_sym]
	end
end
