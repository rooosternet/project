// function trigger_signin_form(){
// 	$('.signin_form').bind('ajax:success',function(event, data, status, xhr){
// 		fid = $(this).data("parent");
// 		$("#"+fid).modal('hide');
// 		window.location.href = "/";
// 	});	

// 	$('.signin_form').bind('ajax:error', function(event, data, status, xhr) {
// 		var msg = "Sign-in resolved in error!!";
// 		if(data.responseText=="Your account is pending approval!"){
// 			$("#modal-signin").modal('hide');
// 			$("#modal-signin-pending-alt").modal('show');
// 		}else if(data.responseText=="Invalid email or password."){
// 			msg = "Invalid email or password.";
// 		}
// 		$("#sign-in-form-error").text(msg);	
// 	});
// };


// ;(function($, window, document, undefined) {
// 	var $win = $(window);
// 	var $doc = $(document);

// 	$doc.ready(function() {

function setupAjaxIndicator() {
  $(document).bind('ajaxSend', function(event, xhr, settings) {
    if ($('.ajax-loading').length === 0 && settings.contentType != 'application/octet-stream') {
      $('#ajax-indicator').show();
    }
  });
  $(document).bind('ajaxStop', function() {
    $('#ajax-indicator').hide();
  });
};

$(document).ready(setupAjaxIndicator);


$(function() {

		console.log("--- ready");	
		// Scroll To
		$('[data-scroll-to]').on('click', function(event) {
			event.preventDefault();
			
			var target = $(this).data('scroll-to');

			$('html, body').animate({
				scrollTop: $(target).offset().top
			}, 500);
		});

		// Button Collapse Form
		$('.btn-collapse-form').bind('click', function(event) {
			console.log("--- .btn-collapse-form");
			event.preventDefault();
			
			$(this).hide();
		});

		// Modal Fix
		$('.header [data-toggle="modal-alt"]').on('click', function(event) {
			event.preventDefault();

			var target = $(this).attr('href');

			if(!$('.modal-backdrop').length) {
				$(target).modal('show');
				return;
			}

			$('.modal').modal('hide');
			setTimeout(function() {
				$(target).modal('show');
			}, 400);
		});

		// Autocomplete
		$('.select-autocomplete').each(function(index, el) {
			var placeholderText = $(this).data('placeholder');
			$(this).fastselect({
				choiceRemoveClass: 'ico-remove btn-remove',
				placeholder: placeholderText
			});
		});

		$('.register_form').bind('ajax:success',function(event, data, status, xhr){
			fid = $(this).data("parent");
			$("#"+fid).modal('hide');
			$("#"+fid+"-alt").modal('show');
		});	

		$('.register_form').bind('ajax:error', function(event, data, status, xhr) {
			fid = $(this).data("error-id");
			$("#"+fid).text(data.responseText);
		});

		$('.register_form').bind('ajax:complete', function(event, data, status, xhr) {

		});


		$('.signin_form').bind('ajax:success',function(event, data, status, xhr){
			fid = $(this).data("parent");
			$("#"+fid).modal('hide');
			window.location.href = "/";
		});	

		$('.signin_form').bind('ajax:error', function(event, data, status, xhr) {
			var msg = "Sign-in resolved in error!!";
			if(data.responseText=="Your account is pending approval!"){
				$("#modal-signin").modal('hide');
				$("#modal-signin-pending-alt").modal('show');
			}else if(data.responseText=="Invalid email or password."){
				msg = "Invalid email or password.";
			}
			$("#sign-in-form-error").text(msg);	
		});


		$('#forget_password_form_id').bind('ajax:success',function(event, data, status, xhr){
			$("#modal-forget-password").modal('hide');
			$("#modal-reset-password-alt").modal('show');
		});	

		$('#forget_password_form_id').bind('ajax:error', function(event, data, status, xhr) {
			$(".form-forget-password-error").text(data.responseText);
		});

		$('.modal').on('show.bs.modal', function (e) {
  			$(this).find(".form-error").html("");
		});

		$('#change_password_form_id').bind('ajax:success',function(event, data, status, xhr){
			$("#modal-change-password").modal('hide');
			window.location.href = "/";
		});	

		$('#change_password_form_id').bind('ajax:error', function(event, data, status, xhr) {
			$(".form-change-password-error").text(data.responseText);
		});

		// modal-signin-link click to sign-in
		// $('#modal-signin-link').on('click', function(event) {
		// 	event.preventDefault();
		// 	var url = $(this).data('url');
		// 	$.ajax({
		// 		url: url,
		// 		type: 'get',
		// 		success: function(sign_in_form){
		// 			$("#signin_form_id").replaceWith(sign_in_form);
		// 			$("#modal-signin").modal('show');
		// 		},
		// 		error: function(data){ 
		// 			console.log(data);
		// 		},
		// 		complete: function(){ 
		// 			trigger_signin_form();
		// 		}
		// 	});	
		// });

});
// })(jQuery, window, document);
