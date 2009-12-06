class TopicsController < ApplicationController
	filter_resource_access
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
	session[:forum_id]=@topic.forum_id
	session[:topic_id]=@topic.id

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
    @topic.forum_id = session[:forum_id]
    #@forum=Forum.id_equals(@topic.forum_id).first

  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

	def create
		@topic = Topic.new(params[:topic])
		if @topic.save
			flash[:notice] = 'Topic was successfully created.'
			redirect_to(@topic)
		else
			render :action => "new"
		end
		@t=Topic.last
		@post=Post.new(:body => @topic.post_body, :forum_id => @topic.forum.id, :user_id => current_user.id, :topic_id => @t.id)
		@post.save
		@t.firstpost_id=@post.id
		@t.save
	end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(topics_url) }
      format.xml  { head :ok }
    end
  end
end
