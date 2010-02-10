$(document).ready(function(){
	//Initialize the Timer
	var myTimer = {};
	
	//Auto Completetion for the new message form
	$('#message_receiver_id').keyup(function(){
		if($(this).val()==""){
			$('#auto_complete_results').html("")
		}else{
			$.getScript('/users?search=' + $(this).val());
		}
	});
	$('#auto_complete_link').live("click",function(){
		$('#message_receiver_id').val($(this).html());
		$('#auto_complete_results').html("")
		return false
	});
	
	//Lets give it a few seconds to show any flash messages from the controller
	myTimer = $.timer(4000,function(){
		checkagain(10000);
	});
});

function checkagain(delay){
	//Start a Timer, dont want it bombarding the server with constant requests
	$.timer(delay,function(){
		$.getScript("/messages.js");
		if(delay <= 600000){
			//RECURSE, see you again in 10 seconds
			checkagain(delay*2);
		}
	});
}
