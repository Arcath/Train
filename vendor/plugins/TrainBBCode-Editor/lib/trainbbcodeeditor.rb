class ActionView::Helpers::FormBuilder
	def tbbce(conf)
		out="<div id=\"tbbce_bar\">You do not have Javascript Enabled</div>"
		out+=text_area conf, :class => 'tbbce_area'
		out+="<div id=\"tbbce_frame\"></div>"
		return out
	end
end
