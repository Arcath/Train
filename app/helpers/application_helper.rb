# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def navlinkwithnext(nav, lis = true, submenu = true)
		if submenu then
			sfnav=Navigation.find(:first, :conditions => "parent = #{nav.id} AND previous IS NULL")
			if sfnav then
				out="<li>"
				out+=navlink(nav,false)
				out += "<ul>"
				out+=navlinkwithnext(sfnav,true,false)
				out+="</ul>"
				out+="</li>"
			else
				out=navlink(nav,lis)
			end
		else
			out=navlink(nav,lis)
		end
		nextnav=Navigation.find(:first, :conditions => "previous = #{nav.id}")
		if nextnav then
			out+=navlinkwithnext(nextnav,lis, submenu)
		else
			return out
		end
	end
	def navlink(nav, lis = true)
		if permitted_to? nav.destination_action.to_sym, nav.destination_controller.to_sym
			out = ""
			if lis == true then out+="<li>" end
			if nav.permalink != "" then
				out+= link_to nav.text, "/permalink/#{nav.permalink}"
			else
				out+= link_to nav.text, navlinkpath(nav)
			end
			if lis == true then out+="</li>" end
			return out
		else
			return ""
		end
	end
	def navlinkpath(nav)
		if nav.destination_id != "" and nav.destination_action != "show" then
			out="/#{nav.destination_controller}/#{nav.destination_action}/#{nav.destination_id}"
		elsif nav.destination_action != "" && nav.destination_action != "index" && nav.destination_action != "show" then
			out="/#{nav.destination_controller}/#{nav.destination_action}"
		elsif nav.destination_action == "show" then
			out="/#{nav.destination_controller}/#{nav.destination_id}"
		else
			out="/#{nav.destination_controller}"
		end
	end
	def jsit(*args)
		args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    		content_for(:jsit) { javascript_include_tag(*args) }
	end
	def sst(*args)
		args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    		content_for(:jsit) { stylesheet_link_tag(*args) }
	end
	def current_page
		request.path_parameters['controller']
	end
	def sidebar
		if current_user
			limit=20
			activities = []
			activities += Post.all(:order => 'created_at DESC', :limit => limit).map do |post|
				Activity.new(post.created_at, "Post", post)
			end
			activities += Planet.all(:order => 'published_at DESC', :limit => limit).map do |post|
				Activity.new(post.published_at, "Planet", post)
			end
			activities += Message.all(:conditions => ["sender_id", current_user.id], :order => 'created_at DESC', :limit => limit).map do |post|
				Activity.new(post.created_at, "SentMessage", post)
			end
			ordered=activities.sort_by(&:date).reverse[0..limit-1]
			out="<ul>"
			ordered.each do |item|
				if item.type == "Post" then
					out+="<li>" + link_to(item.object.topic.title,item.object.topic) + " by " + link_to(item.object.user.username,item.object.user) + "</li>"
				elsif item.type == "Planet" then
					out+="<li>" + item.object.feed(item.object) + " posted " + item.object.name + "</li>"
				elsif item.type == "SentMessage" then
					out+="<li>You Sent " + link_to(item.object.receiver.username,item.object.receiver) + " " + link_to(item.object.title,item.object) + "</li>"
				end
			end
			out+="</ul>"
			return out
		else
			return "Once you are logged in you will be able to see recent news here, be it new topics or posts even posts on the planet"
		end
	end
end
class Activity < Struct.new(:date, :type, :object); end
