$(function(){
	$(".pagination a").live("click", function(){
		$.setFragment({ "page" : $.queryString(this.href).page });
		$("#pagination").html("<img src=\"/images/indicator.gif\" alt=\"\"> Page is Loading");
		$.getScript(this.href);
		return false;
	});
	
	$.fragmentChange(true);
	$(document).bind("fragmentChange.page", function(){
		$.getScript($.queryString(document.location.href, { "page" : $.fragment().page }));
	});
	
	if ($.fragment().page) {
		$(document).trigger("fragmentChange.page");
	}
});
