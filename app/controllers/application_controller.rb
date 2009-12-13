# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter { |c| Authorization.current_user = c.current_user }

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  def permission_denied
  	flash[:error]="You do not have permission to do that"
  	redirect_to root_url
  end
  
  helper_method :current_user
  def current_user_session
  	return @current_user_session if defined?(@current_user_session)
  	@current_user_session = UserSession.find
  end
  def current_user
  	if @current_user != nil then
	  	if session[:forum_id] && session[:topic_id] then
	  		@post=Post.new
	  		@post.forum_id=session[:forum_id]
	  		@post.topic_id=session[:topic_id]
	  		if @post.forum.canposts.include? @current_user.role then
	  			@current_user.postable=true
	  		else
	  			@current_user.postable=false
	  		end
	  		if @post.forum.canmoderates.include? @current_user.role then
	  			@current_user.modable=true
	  		else
	  			@current_user.modable=false
	  		end
	  	elsif session[:forum_id]
	  		@topic=Topic.new
	  		@topic.forum_id=session[:forum_id]
	  		if @topic.forum.cantopics.include? @current_user.role then
	  			@current_user.topicable=true
	  		else
	  			@current_user.topicable=false
	  		end
	  	end
  	end
  	return @current_user if defined?(@current_user)
  	@current_user = current_user_session && current_user_session.record
  end
end
