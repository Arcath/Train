class PostsController < ApplicationController
	filter_resource_access
	def index
		@posts = Post.all
	end
	
	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
		@post.forum_id = session[:forum_id]
		@post.topic_id = session[:topic_id]
		@post.user_id = @current_user.id
	end

	def edit
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(params[:post])
		if @post.save
			flash[:notice] = 'Post was successfully created.'
			redirect_to(@post.topic)
		else
			render :action => "new"
		end
	end

	def update
		@post = Post.find(params[:id])

		if @post.update_attributes(params[:post])
			flash[:notice] = 'Post was successfully updated.'
			redirect_to(@post.topic)
		else
			render :action => "edit"
		end
	end

	def destroy
		@post = Post.find(params[:id])
		topic=@post.topic
		if @post == @post.topic.posts.first then
			forum=topic.forum
			topic.posts.all.each do |post|
				post.destroy
			end
			topic.destroy
			redirect_to(forum)			
		else
			@post.destroy
			redirect_to(topic)
		end
	end
end
