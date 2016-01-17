$(function() {

	$('.edit_user').bind('ajax:success',function(event, data, status, xhr){
		if(status == 'success'){
			fid = $(this).data("parent");
			$("#"+fid).modal('hide');
			// $("#"+fid+"-alt").modal('show');
		}else{
			fid = $(this).data("error-id");
			$("#"+fid).text(data.responseText);
		}

	});	

	$('.edit_user').bind('ajax:error', function(event, data, status, xhr) {
		fid = $(this).data("error-id");
		var text = JSON.parse(data.responseText).responseText;
		if(text === undefined || text == ""){
			text = data.responseText;	
		}
		$("#"+fid).text(text);
	});

	$('.edit_user').bind('ajax:complete', function(event, data, status, xhr) {

	});


});