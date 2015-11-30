;(function($, window, document, undefined) {
	var $win = $(window);
	var $doc = $(document);

	$doc.ready(function() {
		
		// Scroll To
		$('[data-scroll-to]').on('click', function(event) {
			event.preventDefault();
			
			var target = $(this).data('scroll-to');

			$('html, body').animate({
				scrollTop: $(target).offset().top
			}, 500);
		});

		// Button Collapse Form
		$('.btn-collapse-form').on('click', function(event) {
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
			if(status == 'success'){
				fid = $(this).data("parent");
				$("#"+fid).modal('hide');
				$("#"+fid+"-alt").modal('show');
			}else{
				$(".form-error").text(data.responseText);
			}
			
		});	

		$('.register_form').bind('ajax:error', function(event, data, status, xhr) {
		    $(".form-error").text(data.responseText);
		});

		$('.register_form').bind('ajax:complete', function(event, data, status, xhr) {
		    
		});

		

	});
})(jQuery, window, document);
