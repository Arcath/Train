class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.openid_required_fields = [:nickname, :email]
	end
	
	ROLES = %w[admin moderator author content_writer member banned]
	
	def role_symbols
		if role == nil then
			self.role="member"
		end
		[self.role.to_sym]
	end
	
	private
	
	def map_openid_registration(registration)
		self.email = registration["email"] if email.blank?
		self.username = registration["nickname"] if username.blank?		
	end
	
end
