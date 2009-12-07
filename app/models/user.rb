class User < ActiveRecord::Base
	has_many :posts
	
	#Avatar Through PaperClip
	has_attached_file :avatar, :styles => { :tiny => "32x32>", :display => "150x150>" }
	validates_attachment_size :avatar, :less_than => 1.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']
	
	attr_accessor :postable, :topicable, :modable
	acts_as_authentic do |c|
		c.openid_required_fields = [:nickname, :email]
	end
	
	ROLES = %w[admin moderator author content_writer member banned guest]
	
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
