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

	$('#modal-delete').on('show.bs.modal', function(e) {
	    var message_id = $(e.relatedTarget).data('message-id');
	    $(e.currentTarget).find('input[name="in_message[id]"]').val(message_id);
	    // $(e.currentTarget).find('form[id="delete_message_form_id"]').attr('action','/in_messages/'+message_id)
	});

	$('#modal-delete').on('hide.bs.modal', function(e) {
	    $(e.currentTarget).find('input[name="in_message[id]"]').val('');
	    $(e.currentTarget).find('form[id="delete_message_form_id"]').val('');
	});

	$('#delete_message_form_id').bind('ajax:success',function(event, data, status, xhr){
		$('#modal-delete').modal('hide');
		$(".conversations").find('li').last().addClass('active')
		$(".conversations").find('a[href="#conversation'+data+'"]').parent().remove()
		$("#conversation"+data).remove();
		$("#message-"+data).remove();
	});	

	$('#delete_message_form_id').bind('ajax:error', function(event, data, status, xhr) {
	});
	
	$('#delete_message_form_id').bind('ajax:complete', function(event, data, status, xhr) {
	});


	// $('#new_message_form_id').bind('ajax:success',function(event, data, status, xhr){
	// 	$('#modal-delete').modal('hide');
	// 	// $(".conversations").find('li').last().addClass('active')
	// 	// $(".conversations").find('a[href="#conversation'+data+'"]').parent().remove()
	// 	// $("#conversation"+data).remove();
	// 	// $("#message-"+data).remove();
	// });	

	// $('#new_message_form_id').bind('ajax:error', function(event, data, status, xhr) {
	// });
	
	// $('#new_message_form_id').bind('ajax:complete', function(event, data, status, xhr) {
	// });

	$('.new-message').on('click', function(event) {
		// event.preventDefault();
		var elm = $(this);
		var url = elm.data('url');
		var active = $(this).find("i.ico-new-message");
		$.ajax({
			url: url,
			type: 'post',
			success: function(data){
				elm.removeClass('new-message');
				active.removeClass('ico-new-message');
			},
			error: function(data){ 
				console.log(data);
			},
			complete: function(){ 
			}
		});	
	});	
	// console.log("in_message_note");

	$(".toggler").click(function(event) {
		event.preventDefault();
		toggler($(this).data('toggler'));
	});	

	// $(".in-message").keypress(function(event) {
	// 	if ( event.which == 13)
 //    	return false;
	// });


	$('#mass-message').on('shown.bs.collapse', function(e) {
		console.log('mass-message: shown.bs.collapse');
		var profile_ids = $('input:checkbox:checked.checkbox-group1').map(function() {return $(this).data('profile-id');}).get();
		$.each(profile_ids, function( index, value ) {
			$("#recipient_"+value).removeClass('hidden');  
		});
		$("#in_message_to_ids").val(profile_ids);
		$("#team_bulk_message_error").text('');
	});

	$('#mass-message').on('hide.bs.collapse', function(e) {
		console.log('mass-message: hide.bs.collapse');
		var profile_ids = $('input:checkbox:checked.checkbox-group1').map(function() {return $(this).data('profile-id');}).get();
		$.each(profile_ids, function( index, value ) {
			$("#recipient_"+value).addClass('hidden');  
		});
		$("#in_message_to_ids").val([]);
		$("#team_bulk_message_error").text('');
	});

	$('.message-to').bind('ajax:success',function(event, data, status, xhr){
		$(".tab-pane.active .messages-wrapper").append($(data).fadeIn(300));
		$(".tab-pane.active").find('.field-message-content').val('');
	});	

	$('.message-to').bind('ajax:error', function(event, data, status, xhr) {
		console.log(data);
		$("#team_bulk_message_error").text(data.responseText);
	});
	
	$('.message-to').bind('ajax:complete', function(event, data, status, xhr) {
	});

	$('.profile-message-to').bind('ajax:success',function(event, data, status, xhr){
		console.log(data);
		var $target = $("#"+$(this).data('target-id'));
		$target.append($(data).fadeIn(300));
		$(this).find('.field-message-content').val('');
	});	

	$('.profile-message-to').bind('ajax:error', function(event, data, status, xhr) {
		console.log(data);
	});
	
	$('.profile-message-to').bind('ajax:complete', function(event, data, status, xhr) {
	});

	// $('.message-to')
	//     // event handler
	//     .keyup(resizeInput)
	//     // resize on page load
	//     .each(resizeInput);

	});