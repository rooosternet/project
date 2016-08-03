$(function() {

	$(document.body).ready(function(){

		$('#modal-delete-profile-from-team').on('show.bs.modal', function(e) {
		    var team_id = $(e.relatedTarget).data('team-id');
		    var profile_ids = $('input:checkbox:checked.checkbox-group1').map(function() {return $(this).data('profile-id');}).get();
		    $(e.currentTarget).find('input[name="team_profile[team_id]"]').val(team_id);
		    $(e.currentTarget).find('input[name="team_profile[profile_id]"]').val(profile_ids);
		});

		$('.private').click(function(){
			$('.messages').css('background-color', '#fff8fc');
		});

		$('.private').mouseenter(function(){$(this).parents().eq(2).find('#private').addClass('show');$(this).parents().eq(2).css('margin-bottom','40px')});
		$('.private').mouseleave(function(){$(this).parents().eq(2).find('#private').removeClass('show');$(this).parents().eq(2).css('margin-bottom','20px')});

		$('.profile').mouseenter(function(){$(this).parents().eq(2).find('#profile').addClass('show');$(this).parents().eq(2).css('margin-bottom','40px')});
		$('.profile').mouseleave(function(){$(this).parents().eq(2).find('#profile').removeClass('show');$(this).parents().eq(2).css('margin-bottom','20px')});

		$('.admin').mouseenter(function(){$(this).parents().eq(2).find('#admin').addClass('show');$(this).parents().eq(2).css('margin-bottom','40px')});
		$('.admin').mouseleave(function(){$(this).parents().eq(2).find('#admin').removeClass('show');$(this).parents().eq(2).css('margin-bottom','20px')});

		$('.delete').mouseenter(function(){$(this).parents().eq(2).find('#delete').addClass('show');$(this).parents().eq(2).css('margin-bottom','40px')});
		$('.delete').mouseleave(function(){$(this).parents().eq(2).find('#delete').removeClass('show');$(this).parents().eq(2).css('margin-bottom','20px')});

		$('.user-image').click(function(){
			var to_id = $(this).attr('data-user-id');
			var to_name = $(this).attr('data-user-name');
			$('.send-message').attr('placeholder', 'Reply to ' + to_name);
			$('.to-ids').val(to_id);
		})

		$('#modal-delete-profile-from-team').on('hide.bs.modal', function(e) {
		    $(e.currentTarget).find('input[name="team_profile[team_id]"]').val('');
		    $(e.currentTarget).find('input[name="team_profile[profile_id]"]').val('');
		});

		$('#delete_profile_from_team_form_id').bind('ajax:success',function(event, data, status, xhr){
			$('#modal-delete-profile-from-team').modal('hide');
			var count = $('input:checkbox:checked.checkbox-group1').map(function() {return $(this).closest('li.user-alt').remove();}).size();
			if(count > 0){
				var teamcount = $('.team-count');
				before = parseInt(teamcount.text());
				after = before - count;
				teamcount.text(after);
				$('.section-bar span').text($('.section-bar span').text().replace(before,after));
				// if(parseInt(teamcount.text()) == 0){
				// 	teamcount.css('color','#fff');
				// }
			}
		});

		$('#delete_profile_from_team_form_id').bind('ajax:error', function(event, data, status, xhr) {
		});

		$('#delete_profile_from_team_form_id').bind('ajax:complete', function(event, data, status, xhr) {
		});

		// Detete Team
		$('#modal-delete-team').on('show.bs.modal', function(e) {
		    var team_id = $(e.relatedTarget).data('team-id');
		    $(e.currentTarget).find('input[name="team[id]"]').val(team_id);
		    // $(e.currentTarget).find('form[id="delete_team_form_id"]').attr('action','/teams/'+message_id+/archive)
		});

		$('#modal-delete-team').on('hide.bs.modal', function(e) {
		    $(e.currentTarget).find('input[name="team_profile[id]"]').val('');
		});

		$('#delete_team_form_id').bind('ajax:success',function(event, data, status, xhr){
			$('#modal-delete-team').modal('hide');
			window.location.href = "/";
		});

		$('#delete_team_form_id').bind('ajax:error', function(event, data, status, xhr) {
		});

		$('#delete_team_form_id').bind('ajax:complete', function(event, data, status, xhr) {
		});


		// replace Team image
		$('#modal-avatar').on('show.bs.modal', function(e) {
			var image = $(e.relatedTarget).find(".team-image-selected").attr('src');
		    $(e.currentTarget).find(".team-image-selected").attr('src',image);
		});

		$('#modal-avatar').on('hide.bs.modal', function(e) {
		    $(e.currentTarget).find(".team-image-selected").attr('src','');
		});
	});

});
