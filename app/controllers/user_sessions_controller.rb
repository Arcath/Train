class UserSessionsController < ApplicationController
	filter_resource_access
  def new
    @user_session = UserSession.new
  end
  
	def create
		@user_session = UserSession.new(params[:user_session])
		@user_session.save do |result|
			if result
				flash[:notice] = 'Login Successful.'
				goto = (request.env['HTTP_REFERER'] if request.env['HTTP_REFERER'] != "/login") || root_url
				redirect_to goto
			else
				render :action => "new" 
			end
		end
	end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Logout Successful"
    redirect_to root_url
  end
end
