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
		if nav.destination_id != "" then
			out="/#{nav.destination_controller}/#{nav.destination_action}/#{nav.destination_id}"
		elsif nav.destination_action != "" && nav.destination_action != "index" then
			out="/#{nav.destination_controller}/#{nav.destination_action}"
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
end
