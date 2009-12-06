module ForumsHelper
	def toplevel(forum)
		if permitted_to? :show, forum then
			out="<p>"
			out+="<b>#{forum.name}</b>"
			subforum=Forum.parent_equals(forum.id).previous_equals(nil).first
			if subforum then
				out+=sublevel(subforum)
			end
			out+="</p>"
		else
			out=""
		end
		nextforum=Forum.find(:first,:conditions => "previous = #{forum.id}")
		if nextforum then
			out+=toplevel(nextforum)
		end
		return out
	end
	
	def sublevel(forum)
		if permitted_to? :show, forum then
			out="<p>"
			out+=link_to forum.name, forum_url(forum)
			out+=" Topics: #{forum.topics.count}, Posts #{forum.posts.count}"
			if forum.topics.last then
				out+=", Latest by "
				out+= link_to forum.posts.last.user.username, user_path(forum.posts.last.user)
				out+=" in "
				out+= link_to forum.posts.last.topic.title, topic_path(forum.topics.last)
			end
			if permitted_to? :edit, forum
				out+=link_to " (edit forum)", edit_forum_path(forum)
			end
			out+="<br /><span class=\"fdesc\">#{forum.description}</span>"
			out+="</p>"
		else
			out=""
		end
		nextforum=Forum.find(:first,:conditions => "previous = #{forum.id}")
		if nextforum then
			out+=sublevel(nextforum)
		end
		return out
	end
end
