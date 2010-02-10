$(function(){
	$("#statistics a").click(function(){
		return false
	});

  flashmessage();
  
  $(".colourize a").bind("mouseenter", function(){
        $(this).data("text", $(this).text());
		$(this).html(colorize($(this).text()));
	}).bind("mouseleave", function(){
		$(this).html($(this).data("text"));
	});
  $('#collapse_link').html("Collapse Header");
  /*$('#usermenu a').live("click",function(){
  	$('#header').("slow");
  	
  	return false
  });*/
  $('#collapse_link').toggle(function(){
  	$('#header').slideUp('slow');
  	$(this).html("Restore Header");
  	return false
  },function(){
  	$('#header').slideDown('slow');
  	$(this).html("Collapse Header");
  	return false
  });
});

var colcolors = ["#6970B4", "#5AC306", "#DA2E0A", "#FE8A03", "#1840A0"]

function colorize(text) {
    var colorized = ""
    var bracket_color = ""
    for (i = 0; i < text.length; i++) {
        var index = Math.floor(Math.random()*5)
        if (text[i] == "(")
            bracket_color = colcolors[index]
    
        color = (bracket_color.length && (text[i] == "(" || text[i] == ")")) ? bracket_color : colcolors[index]
        colorized = colorized + '<span style="color: '+color+' !important">' + text.charAt(i) + '</span>'
    }
    return colorized
}

function flashmessage(){
var alert = $('.flash');
  if (alert.length > 0) {
    alert.show().animate({height: alert.outerHeight()}, 200);

    window.setTimeout(function() {
      alert.slideUp();
    }, 3000);
  }
}
