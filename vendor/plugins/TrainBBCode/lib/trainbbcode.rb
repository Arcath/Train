class TBBC
	def initialize
		self.conf(:configed_by => "system")
	end
	def conf(config)
		require 'rubygems'
		config[:configed_by] ||= "user"
		config[:image_alt] ||= "Posted Image" 
		config[:url_target] ||= "_BLANK"
		config[:allow_defaults] ||= true
		config[:table_width] ||= "100%"
		config[:syntax_theme] ||= "Default"
		config[:syntax_themes] = ["Default","Django","Eclipse","Emacs","FadeToGrey","Midnight","RDark"]
		#Instanize the config variable
		@config=config
	end
	def parse(s)
		#Remove the < and > which will disable all HTML
		s=s.gsub("<","&lt;").gsub(">","&gt;") unless @config[:disable_html] == false
		#Convert new lines to <br />'s
		s=s.gsub(/\n/,'<br />') unless @config[:newline_enabled] == false
		#[nobbc] tags
		s=nobbc s unless @config[:nobbc_enabled] == false
		#Loading Custom Tags
		begin
			if @config[:custom_tags] then
				@config[:custom_tags].each do |tag|
					if tag[3] then
						a=s.split(tag[0])
						if a[2] then
							r=a[2].gsub(/<br \/>/,'')
							s=s.gsub("#{a[2]}",r)
						end
					end
					s=s.gsub(tag[0],tag[1]) unless tag[2] == false
				end
			end
		rescue
			s+="<br />Custom Tags failed to run"
		end
		#Loading Default Tags and applying them
		if @config[:allow_defaults] then
			tags=load_default_tags
			tags.each do |tag|
				if tag[3] then
					a=s.split(tag[0])
					if a[2] then
						r=a[2].gsub(/<br \/>/,'')
						s=s.gsub("#{a[2]}",r)
					end
				end
				s=s.gsub(tag[0],tag[1]) unless tag[2] == false
			end	
		end
		s=correctbrs s
		return s
	end
	def load_default_tags
		tags=[
			#Bold
			[/\[b\](.*?)\[\/b\]/,'<strong>\1</strong>',@config[:strong_enabled],false],
			#Italic
			[/\[i\](.*?)\[\/i\]/,'<i>\1</i>',@config[:italic_enabled],false],
			#Underline
			[/\[u\](.*?)\[\/u\]/,'<u>\1</u>',@config[:underline_enabled],false],
			#Url
			[/\[url\](.*?)\[\/url\]/,'<a href="\1" target="' + @config[:url_target] +'">\1</a>',@config[:url_enabled],false],
			[/\[url=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="' + @config[:url_target] + '">\2</a>',@config[:url_enabled],false],
			[/\[url=(.*?) target=(.*?)\](.*?)\[\/url\]/,'<a href="\1" target="\2">\3</a>',@config[:url_enabled],false],
			#Image
			[/\[img\](.*?)\[\/img\]/,'<img src="\1" alt="'+ @config[:image_alt] + '" />',@config[:image_enabled],false],
			[/\[img alt=(.*?)\](.*?)\[\/img\]/,'<img src="\2" alt="\1" />',@config[:image_enabled],false],
			#Un-Ordered List
			[/\[ul\](.*?)\[\/ul\]/,'<ul>\1</ul>',@config[:list_enabled],false],
			#Ordered List
			[/\[ol\](.*?)\[\/ol\]/,'<ol>\1</ol>',@config[:list_enabled],false],
			#List Item
			[/\[li\](.*?)\[\/li\]/,'<li>\1</li>',@config[:list_enabled],false],
			#Quote
			[/\[quote\](.*?)\[\/quote\]/,'<blockquote>\1</blockquote>',@config[:quote_enabled],false],
			[/\[quote=(.*?)\](.*?)\[\/quote\]/,'<blockquote><i>Posted by <b>\1</b></i><br />\2</blockquote>',@config[:quote_enabled],false],
			#Color
			[/\[color=(.*?)\](.*?)\[\/color\]/,'<span style="color:\1;">\2</span>',@config[:color_enabled],false],
			#Alignment
			[/\[center\](.*?)\[\/center\]/,'<div style="text-align:center">\1</div>',@config[:alignment_enabled],false],
			[/\[left\](.*?)\[\/left\]/,'<div style="text-align:left">\1</div>',@config[:alignment_enabled],false],
			[/\[right\](.*?)\[\/right\]/,'<div style="text-align:right">\1</div>',@config[:alignment_enabled],false],
			#Acronym
			[/\[acronym=(.*?)\](.*?)\[\/acronym\]/,'<acronym title="\1">\2</acronym>',@config[:acronym_enabled],false],
			#Tables
			#Table Tag
			[/\[table\](.*?)\[\/table\]/,'<table width="' + @config[:table_width]+ '">\1</table>',@config[:table_enabled],false],
			#Table Elements
			[/\[tr\](.*?)\[\/tr\]/,'<tr>\1</tr>',@config[:table_enabled],false],
			[/\[td\](.*?)\[\/td\]/,'<td>\1</td>',@config[:table_enabled],false],
			[/\[th\](.*?)\[\/th\]/,'<th>\1</th>',@config[:table_enabled],false],
			#Code
			[/\[code lang=(.*?)\](.*?)\[\/code\]/,'<pre name="code" class="brush: \1;">\2</pre>',@config[:code_enabled],true]
		]
	end
	def nobbc(s)
		find=s.scan(/\[nobbc\](.*?)\[\/nobbc\]/)
		find.each do |f|
			replace=f[0].gsub("[","&#91;").gsub("]","&#93")
			s=s.gsub("[nobbc]#{f[0]}[/nobbc]",replace)
		end
		return s
	end
	def correctbrs(s)
		#Corrects the extra brs
		s=s.gsub(/<br \/><(ul|li|table|tr|td|th|pre)/,'<\1')
		s=s.gsub(/<br \/><\/(ul|li|table|tr|td|th|pre)/,'</\1')
	end
	def header
		"<script type=\"text/javascript\" src=\"/javascripts/syntax/shCore.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushBash.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushCpp.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushCSharp.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushCss.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushDelphi.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushDiff.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushGroovy.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushJava.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushJScript.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushPhp.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushPlain.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushPython.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushRuby.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushScala.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushSql.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushVb.js\"></script> 
		<script type=\"text/javascript\" src=\"/javascripts/syntax/shBrushXml.js\"></script> 
		<link type=\"text/css\" rel=\"stylesheet\" href=\"/stylesheets/syntax/shCore.css\"/> 
		<link type=\"text/css\" rel=\"stylesheet\" href=\"/stylesheets/syntax/shTheme#{@config[:syntax_theme]}.css\"/> 
		<script type=\"text/javascript\"> 
			SyntaxHighlighter.config.clipboardSwf = '/javascripts/syntax/clipboard.swf';
			SyntaxHighlighter.all();
		</script>"
	end
end

#Add .tbbc to Strings
class String
	def tbbc(conf = nil)
		bbc=TBBC.new
		bbc.conf(conf) if conf
		bbc.parse(self)
	end
end

#Add the Helper Methods
module ApplicationHelper
	def syntax_highlighter_header(tbbc = TBBC.new)
		tbbc.header
	end
end
