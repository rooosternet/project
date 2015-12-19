$(function() {

	$('.edit_user').bind('ajax:success',function(event, data, status, xhr){
		if(status == 'success'){
			fid = $(this).data("parent");
			$("#"+fid).modal('hide');
			// $("#"+fid+"-alt").modal('show');
		}else{
			$(".form-error").text(data.responseText);
		}

	});	

	$('.edit_user').bind('ajax:error', function(event, data, status, xhr) {
		$(".form-error").text(data.responseText);
	});

	$('.edit_user').bind('ajax:complete', function(event, data, status, xhr) {

	});


});
