// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function resizeInput() {
	$(this).attr('size', $(this).val().length);
}

function toggler(divId) {
	$("#" + divId).toggle();
	$("#" + divId + "[id=in_message_note]").focus();
}

$(function() {
	// console.log("in_message_note");

	$(".toggler").click(function(event) {
		event.preventDefault();
		toggler($(this).data('toggler'));
	});	

	// $(".in-message").keypress(function(event) {
	// 	if ( event.which == 13)
 //    	return false;
	// });

	$('.message-to').bind('ajax:success',function(event, data, status, xhr){
	});	

	$('.message-to').bind('ajax:error', function(event, data, status, xhr) {
	});
	
	$('.message-to').bind('ajax:complete', function(event, data, status, xhr) {
		$("#"+ data.responseText +" [id=in_message_note]").css('text-align' , 'center');
		$("#"+ data.responseText +" [id=in_message_note]").val("");
		$("#"+ data.responseText +" [id=in_message_note]").attr('placeholder' , 'Thanks! your message was sent.');

		setTimeout(function () {
			$("#"+ data.responseText +" [id=in_message_note]").css('text-align' , 'left');
   			$("#"+ data.responseText +" [id=in_message_note]").attr('placeholder' , 'Your message');
       		$("#"+data.responseText).hide();
   		}, 4000);
	});

	// $('.message-to')
	//     // event handler
	//     .keyup(resizeInput)
	//     // resize on page load
	//     .each(resizeInput);

	});