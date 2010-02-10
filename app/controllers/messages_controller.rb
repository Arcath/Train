class MessagesController < ApplicationController
	filter_resource_access
	def index
		@messages = Message.find(:all, :conditions => "receiver_id = '#{current_user.id}' AND `read` = '1'")
		@newmessages = Message.find(:all, :conditions => "receiver_id = '#{current_user.id}' AND `read` = '0'")
	end
	
	def show
		@message = Message.find(params[:id])
		if @message.receiver_id == current_user.id then
			@message.read = true
			@message.save
		end
	end

	def new
		@message = Message.new
	end

	def edit
		@message = Message.find(params[:id])
	end

	def create
		@message = Message.new(params[:message])
		@message.read = false
		@message.sender_delete = false
		@message.receiver_delete = false
		@receiver = User.find_by_username(params[:message][:receiver_id])
		if @receiver then
			@message.receiver_id = @receiver.id
			@message.sender_id = current_user.id
			if @message.save
				flash[:notice] = 'Message was successfully created.'
				redirect_to(@message)
			else
				render :action => "new"
			end
		else
			flash[:error] = 'Recipient does not exist'
			render :action => "new"
		end
	end

	def update
		@message = Message.find(params[:id])
		if @message.update_attributes(params[:message])
			flash[:notice] = 'Message was successfully updated.'
			redirect_to(@message)
		else
			render :action => "edit"
		end
	end

	def destroy
		@message = Message.find(params[:id])
		@message.destroy
		redirect_to(messages_url)
	end
end
