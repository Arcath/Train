# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def navlinkwithnext(nav, lis = true)
		out=navlink(nav,lis)
		nextnav=Navigation.find(:first, :conditions => "previous = #{nav.id}")
		if nextnav then
			out+=navlinkwithnext(nextnav,lis)
		else
			return out
		end
	end
	def navlink(nav, lis = true)
		if permitted_to? nav.destination_action.to_sym, nav.destination_controller.to_sym
			if lis == true then out="<li>" end
			if nav.permalink != "" then
				out+= link_to nav.text, "/permalink/#{nav.permalink}"
			else
				out+= link_to nav.text, navlinkpath(nav)
			end
			if lis == true then out+="</li>" end
			return out
		else
			return "NO"
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
end
