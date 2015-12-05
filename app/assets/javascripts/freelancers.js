$(function() {

	$('#submit_search_form').bind('click', function (event) {
		
		var value = $("#search").val();
		if(value == ""){
			event.preventDefault();
			$("#search").attr('placeholder',"Enter search string here...");
			return false;
		}
		return true;
	});


	$('#invite_form').bind('ajax:success',function(event, data, status, xhr){
		if(status == 'success'){
			$(this).find("input[type=text], textarea").val("");
			$(".form-error").text(data.responseText);
		}
	});	

	$('#invite_form').bind('ajax:error', function(event, data, status, xhr) {
		$(".form-error").text(data.responseJSON.responseText);
	});

	$('#invite_form').bind('ajax:complete', function(event, data, status, xhr) {

	});

});