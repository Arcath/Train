class TbbceController < ApplicationController
	def index
		@string=params[:string].tbbc(:custom_tags => [[/-nl-/,"<br />",true],[/\[hash\]/,'#',true]])
		@tbbcef=params[:tbbcef]
	end
end
