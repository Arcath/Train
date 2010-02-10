class Message < ActiveRecord::Base
	belongs_to :sender, :class_name => 'User'
	belongs_to :receiver, :class_name => 'User'
	
	def receiver_name
		receiver.username if receiver
	end
	
	def receiver_name=(name)
		self.receiver = User.find_by_username(name) unless name.blank
	end
end
