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
		$(this.in_message_note).val("");
	});

	// $('.message-to')
	//     // event handler
	//     .keyup(resizeInput)
	//     // resize on page load
	//     .each(resizeInput);

	});