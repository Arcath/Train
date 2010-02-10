$(document).ready(function(){
	//jQuery Objects
	tbbcebar=$('#tbbce_bar');
	tbbcearea=$('.tbbce_area');
	tbbceframe=$('#tbbce_frame');
	$('.preview').live("click",function(){
		s=nl2br(tbbcearea.attr("value"));
		send=s.replace(/#/g,'[hash]');
		$.getScript("/tbbce?string=" + send + "&tbbcef=" + tbbceframe.attr("id"));
		tbbceframe.slideDown("slow");
		tbbcearea.slideUp("slow");
		$(this).removeClass("preview");
		$(this).addClass("closepreview");
		$(this).attr("src","/images/tbbce/cog_delete.png");
	});
	$('.closepreview').live("click",function(){
		tbbceframe.slideUp("slow");
		tbbcearea.slideDown("slow");
		$(this).removeClass("closepreview");
		$(this).addClass("preview");
		$(this).attr("src","/images/tbbce/cog_go.png");
	});
	$('.about').live("click",function(){
		tbbceframe.html("<b>Train BBCode Editor</b><br /><br />Written by Arcath &lt;<a href=\"http://www.arcath.net\" target=\"_BLANK\">http://www.arcath.net</a>&gt;<br />Icons by <a href=\"http://www.famfamfam.com\">FamFamFam</a><br /><br />TBBCE is an editor for <a href=\"http://www.arcath.net/pages/2\" target=\"_BLANK\">TrainBBCode</a>. <a href=\"http://www.arcath.net/pages/4\" target=\"_BLANK\">Want an editor like this in your rails app?</a>");
		tbbceframe.slideDown("slow");
		tbbcearea.slideUp("slow");
		$(this).removeClass("about");
		$(this).addClass("closeabout");
		$(this).text("Close");
		return false
	});
	$('.closeabout').live("click",function(){
		tbbceframe.slideUp("slow");
		tbbcearea.slideDown("slow");
		$(this).removeClass("closeabout");
		$(this).addClass("about");
		$(this).text("About");
		return false
	});
	$('.colorsel #close').live("click",function(){
		tbbceframe.slideUp("slow");
		tbbcearea.slideDown("slow");
		return false
	});
	$('#colorselection').live("click",function(){
		selection=tbbcearea.getSelection();
		var s = "[color=~ins~]STRING[/color]";
		output=s.replace(/STRING/i, selection.text);
		out=output.replace(/~ins~/i, $(this).css("background-color"));
		tbbcearea.replaceSelection(out,true);
		tbbceframe.slideUp("slow");
		tbbcearea.slideDown("slow");
		return false
	});
	//Build the TBBCE bar
	tbbcebar.css("background-color","#FFF");
	tbbcebar.css("width","505px");
	tbbcebar.css("padding","4px");
	tbbcebar.css("font-size","17px");
	tbbcebar.html("<img src=\"/images/tbbce/text_bold.png\" class=\"formatting\" id=\"bold\" style=\"border:none; padding-right:4px;\" alt=\"Bold\" />");
	tbbcebar.append("<img src=\"/images/tbbce/text_italic.png\" class=\"formatting\" id=\"italic\" style=\"border:none; padding-right:4px;\" alt=\"Italic\" />");
	tbbcebar.append("<img src=\"/images/tbbce/text_underline.png\" class=\"formatting\" id=\"underline\" style=\"border:none; padding-right:4px;\" alt=\"Underline\" />");
	tbbcebar.append("<img src=\"/images/tbbce/color_wheel.png\" class=\"formatting\" id=\"color\" style=\"border:none; padding-right:4px;\" alt=\"Color\" />");
	tbbcebar.append("<img src=\"/images/tbbce/text_align_left.png\" class=\"formatting\" id=\"left\" style=\"border:none; padding-right:4px;\" alt=\"Left Align\" />");
	tbbcebar.append("<img src=\"/images/tbbce/text_align_center.png\" class=\"formatting\" id=\"center\" style=\"border:none; padding-right:4px;\" alt=\"Center\" />");
	tbbcebar.append("<img src=\"/images/tbbce/text_align_right.png\" class=\"formatting\" id=\"right\" style=\"border:none; padding-right:4px;\" alt=\"Right Align\" />");
	tbbcebar.append("| <img src=\"/images/tbbce/image.png\" class=\"formatting\" id=\"img\" style=\"border:none; padding-right:4px;\" alt=\"Image\" />");
	tbbcebar.append("<img src=\"/images/tbbce/link.png\" class=\"formatting\" id=\"url\" style=\"border:none; padding-right:4px;\" alt=\"Link\" />");
	tbbcebar.append("<img src=\"/images/tbbce/plugin.png\" class=\"formatting\" id=\"code\" style=\"border:none; padding-right:4px;\" alt=\"Code\" />");
	tbbcebar.append("| <img src=\"/images/tbbce/comment.png\" class=\"formatting\" id=\"quote\" style=\"border:none; padding-right:4px;\" alt=\"Quote\" />");
	tbbcebar.append("<img src=\"/images/tbbce/comments.png\" class=\"formatting\" id=\"quote2\" style=\"border:none; padding-right:4px;\" alt=\"Quote with Name\" />");
	tbbcebar.append("| <img src=\"/images/tbbce/table.png\" class=\"formatting\" id=\"table\" style=\"border:none; padding-right:4px;\" alt=\"Table\" />");
	tbbcebar.append("<img src=\"/images/tbbce/table_row_insert.png\" class=\"formatting\" id=\"tr\" style=\"border:none; padding-right:4px;\" alt=\"Table Row\" />");
	tbbcebar.append("<img src=\"/images/tbbce/table_row_delete.png\" class=\"formatting\" id=\"td\" style=\"border:none; padding-right:4px;\" alt=\"Table Cell\" />");
	tbbcebar.append("<img src=\"/images/tbbce/table_error.png\" class=\"formatting\" id=\"th\" style=\"border:none; padding-right:4px;\" alt=\"Table Header\" />");
	tbbcebar.append("| <img src=\"/images/tbbce/text_list_bullets.png\" class=\"formatting\" id=\"ul\" style=\"border:none; padding-right:4px;\" alt=\"Bulleted List\" />");
	tbbcebar.append("<img src=\"/images/tbbce/text_list_numbers.png\" class=\"formatting\" id=\"ol\" style=\"border:none; padding-right:4px;\" alt=\"Numbered List\" />");
	tbbcebar.append("| <img src=\"/images/tbbce/cog_go.png\" class=\"preview\" style=\"border:none; padding-right:4px;\" alt=\"Preview\" />");
	tbbcebar.append("<img src=\"/images/tbbce/information.png\" class=\"about\" style=\"border:none; padding-right:4px;\" alt=\"About\" />");
	//Handle the links
	$('#tbbce_bar .formatting').live("click",function(){
		processtag(this.id,tbbcearea,tbbceframe);
		tbbceframe.html(tbbcearea.value)
		return false
	});
	//Format the text area
	tbbcearea.attr("cols",70);
	tbbcearea.attr("rows",10);
	//Now lets hide that for the WYSIWYG bit
	//tbbcearea.css("display","none");
	//Draw the frame
	tbbceframe.css("width","509px");
	tbbceframe.css("height","200px");
	tbbceframe.css("border","2px solid #CCC");	
	tbbceframe.css("display","none");
	tbbceframe.css("overflow","auto");
	tbbcearea.css("background-color",$('body').css("background-color"));
	tbbcearea.css("color",$('body').css("color"));
});

function processtag(tag,tbbcearea,tbbceframe){
	//Tags array
	var tags = []
	tags["bold"]="[b]STRING[/b]";
	tags["underline"]="[u]STRING[/u]";
	tags["italic"]="[i]STRING[/i]";
	tags["img"]="[img]STRING[/img]";
	tags["code"]="[code lang=LANGUAGE]STRING[/code]";
	tags["center"]="[center]STRING[/center]";
	tags["left"]="[left]STRING[/left]";
	tags["right"]="[right]STRING[/right]";
	tags["url"]="[url=LINK]STRING[/url]";
	tags["quote"]="[quote]STRING[/quote]";
	tags["quote2"]="[quote=NAME]STRING[/quote]";
	tags["table"]="[table]STRING[/table]";
	tags["tr"]="[tr]STRING[/tr]";
	tags["td"]="[td]STRING[/td]";
	tags["th"]="[th]STRING[/th]";
	tags["color"]="callback";
	tags["ul"]="[ul]\n[li]STRING[/li]\n[/ul]"
	tags["ol"]="[ol]\n[li]STRING[/li]\n[/ol]"
	//Get the Selection
	selection=tbbcearea.getSelection();
	if(tags[tag]=="callback"){
		eval(tag + "(selection,tbbceframe,tbbcearea)");
		output=selection.text;
	}else{
		output=tags[tag].replace(/STRING/i, selection.text);
	}
	//Send Output
	tbbcearea.replaceSelection(output,true);
};

function nl2br(text){
	text = escape(text);
	if(text.indexOf('%0D%0A') > -1){
		re_nlchar = /%0D%0A/g ;
	}else if(text.indexOf('%0A') > -1){
		re_nlchar = /%0A/g ;
	}else if(text.indexOf('%0D') > -1){
		re_nlchar = /%0D/g ;
	}
	return unescape( text.replace(re_nlchar,'-nl-') );
}

function color(s,tbbceframe,tbbcearea){
	sub="[color=COL]STRING[/color]";
	tbbceframe.addClass("colorsel");
	tbbceframe.html("<b>Select a Color</b><br /><br />");
	tbbceframe.append(colors("aliceblue"));
	//tbbceframe.append(colors("AntiqueWhites"));
	tbbceframe.append(colors("Aqua"));
	tbbceframe.append(colors("Aquamarine"));
	tbbceframe.append(colors("Azure"));
	tbbceframe.append(colors("Beige"));
	tbbceframe.append(colors("Bisque"));
	tbbceframe.append(colors("Black"));
	tbbceframe.append(colors("BlanchedAlmond"));
	tbbceframe.append(colors("Blue"));
	tbbceframe.append(colors("BlueViolet"));
	tbbceframe.append(colors("Brown"));
	tbbceframe.append(colors("BurlyWood"));
	tbbceframe.append(colors("CadetBlue"));
	tbbceframe.append(colors("Chartreuse"));
	tbbceframe.append(colors("Chocolate"));
	tbbceframe.append(colors("Coral"));
	tbbceframe.append(colors("CornflowerBlue"));
	tbbceframe.append(colors("Cornsilk"));
	tbbceframe.append(colors("Crimson"));
	tbbceframe.append(colors("Cyan"));
	tbbceframe.append(colors("DarkBlue"));
	tbbceframe.append(colors("DarkCyan"));
	tbbceframe.append(colors("DarkGoldenRod"));
	tbbceframe.append(colors("DarkGray"));
	tbbceframe.append(colors("DarkGreen"));
	tbbceframe.append(colors("DarkKhaki"));
	tbbceframe.append(colors("DarkMagenta"));
	tbbceframe.append(colors("DarkOliveGreen"));
	tbbceframe.append(colors("DarkOrange"));
	tbbceframe.append(colors("DarkOrchid"));
	tbbceframe.append(colors("DarkRed"));
	tbbceframe.append(colors("DarkSalmon"));
	tbbceframe.append(colors("DarkSeaGreen"));
	tbbceframe.append(colors("DarkSlateBlue"));
	tbbceframe.append(colors("DarkSlateGray"));
	tbbceframe.append(colors("DarkTurquoise"));
	tbbceframe.append(colors("DarkViolet"));
	tbbceframe.append("<br /><br /><a href=\"\" id=\"close\">Cancel</a>");
	tbbceframe.slideDown("slow");
	tbbcearea.slideUp("slow");
}

function colors(color){
	return "<a href=\"\" id=\"colorselection\" style=\"margin:2px; float:left; display:block; width:10px; height:10px; background-color:" + color + ";\"> &nbsp;</a>";
}
