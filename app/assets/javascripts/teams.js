$(function() {

	$(document.body).ready(function(){

		$('#modal-delete-profile-from-team').on('show.bs.modal', function(e) {
		    var team_id = $(e.relatedTarget).data('team-id');
		    var profile_id = $(e.relatedTarget).data('profile-id');
		    var profile_ids = $('input:checkbox:checked.checkbox-group1').map(function() {return $(this).data('profile-id');}).get();
		    $(e.currentTarget).find('input[name="team_profile[team_id]"]').val(team_id);
		    $(e.currentTarget).find('input[name="team_profile[profile_id]"]').val((profile_ids.length>0)? profile_ids : profile_id);
		});

		$('.private').click(function(){
			$('.messages').css('background-color', '#fff8fc');
		});

		$('.private').mouseenter(function(){$(this).parents().eq(2).find('#private').addClass('show')});
		$('.private').mouseleave(function(){$(this).parents().eq(2).find('#private').removeClass('show')});

		$('.profile').mouseenter(function(){$(this).parents().eq(2).find('#profile').addClass('show')});
		$('.profile').mouseleave(function(){$(this).parents().eq(2).find('#profile').removeClass('show')});

		$('.admin').mouseenter(function(){$(this).parents().eq(2).find('#admin').addClass('show')});
		$('.admin').mouseleave(function(){$(this).parents().eq(2).find('#admin').removeClass('show')});

		$('.delete').mouseenter(function(){$(this).parents().eq(2).find('#delete').addClass('show');});
		$('.delete').mouseleave(function(){$(this).parents().eq(2).find('#delete').removeClass('show');});
		// $('.delete').mouseleave(function(){$(this).parents().eq(2).find('#delete').removeClass('show');$(this).parents().eq(2).css('margin-bottom','20px')});

		$('.user-image').click(function(){
			var to_id = $(this).attr('data-user-id');
			var to_name = $(this).attr('data-user-name');
			// $('.send-message').attr('placeholder', 'Reply to ' + to_name);
			// $('.to-ids').val(to_id);
		})

		$('.add-invite-btn').click(function(){
			var ico = $(this).find('i');
			var span = $(this).find('span.plus-btn');
			var tab = $('.invite-tab');
			if(ico.hasClass('ico-plus')){
				span.removeClass('team-add');
				ico.removeClass('ico-plus');
				ico.addClass('ico-plus-red');
				tab.show();
			}else{
				span.addClass('team-add');
				ico.removeClass('ico-plus-red');
				ico.addClass('ico-plus');
				tab.hide();
			}
		})

		$('#modal-delete-profile-from-team').on('hide.bs.modal', function(e) {
		    $(e.currentTarget).find('input[name="team_profile[team_id]"]').val('');
		    $(e.currentTarget).find('input[name="team_profile[profile_id]"]').val('');
		});

		$('#delete_profile_from_team_form_id').bind('ajax:success',function(event, data, status, xhr){
			$('#modal-delete-profile-from-team').modal('hide');
		    location.reload();
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
			window.location.replace("/");
		});

		$('#delete_team_form_id').bind('ajax:error', function(event, data, status, xhr) {
			window.location.replace("/");
		});

		$('#delete_team_form_id').bind('ajax:complete', function(event, data, status, xhr) {
			window.location.replace("/");
		});


		// replace Team image
		$('#modal-avatar').on('show.bs.modal', function(e) {
			var image = $(e.relatedTarget).find(".team-image-selected").attr('src');
		    $(e.currentTarget).find(".team-image-selected").attr('src',image);
		});

		$('#modal-avatar').on('hide.bs.modal', function(e) {
		    $(e.currentTarget).find(".team-image-selected").attr('src','');
		});

		var videoEmbed = {
		    invoke: function(){

		        $('.message-entry').html(function(i, html) {
		            return videoEmbed.convertMedia(html);
		        });

		    },
		    convertMedia: function(html){
		        var pattern1 = /(?:http?s?:\/\/)?(?:www\.)?(?:vimeo\.com)\/?(.+)/g;
		        var pattern2 = /(?:http?s?:\/\/)?(?:www\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=)?(.+)/g;
		        var pattern3 = /(https?:\/\/.*\.[png,jpg,gif,jpeg]+)/g;
		        var pattern4 = /(https?:\/\/[^\s]+)/g;


		        if(pattern1.test(html)){
		           var replacement = '<iframe width="420" height="345" src="//player.vimeo.com/video/$1" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';
		           var html = html.replace(pattern1, replacement);
		        }else if(pattern2.test(html)){
		              var replacement = '<iframe width="640" height="480" src="http://www.youtube.com/embed/$1" frameborder="0" allowfullscreen></iframe>';
		              var html = html.replace(pattern2, replacement);
		        }else if(pattern3.test(html)){
		            var replacement = '<a href="$1" target="_blank"><img class="sml" src="$1" /></a><br />';
		            var html = html.replace(pattern3, replacement);
		        }else if(pattern4.test(html)){
		            var replacement = '<a href="$1" target="_blank">$1</a><br />';
		            var html = html.replace(pattern4, replacement);
		        }

		        return html;

		    }
		}
		setTimeout(function(){
		    videoEmbed.invoke();
			$('.chat .messages').scrollTop($('.chat .messages')[0].scrollHeight+600);
		},1000);
	});
});
