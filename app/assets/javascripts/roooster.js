var create_team = function(attributes,target){
	console.log(attributes);
	$.ajax({
		url: "/teams/",
		type: 'post',
		data: {team: attributes },
		dataType: 'script',
		success: function(data){
			console.log(data);
			$("a.team-inner").filter("[href='#']").attr('href',"/teams/" + data);
			if(target){
				target.attr('data-team',data);
			}
		},
		error: function(data){ 
			console.log(data);
		},
		complete: function(data){
			console.log(data);
		}
	});	
}


var add_profile_to_team = function(profile_id,team_id){
	console.log(profile_id +" "+ team_id);
	$.ajax({
		url: "/teams/"+team_id,
		type: 'PUT',
		data: {team: {team_profiles_attributes: {team_id: team_id, profile_id: profile_id} }},
		dataType: 'script',
		success: function(data){
			console.log(data);
		},
		error: function(data){ 
			console.log(data);
		},
		complete: function(data){
			console.log(data);
			return data; 
		}
	});	
}

var remove_profile_from_team = function(profile_id,team_id){
	console.log(profile_id +" "+ team_id);
	$.ajax({
		url: "/teams/remove_profile",
		type: 'POST',
		data: {team_profile: {team_id: team_id, profile_id: profile_id}},
		dataType: 'script',
		success: function(data){
			console.log(data);
		},
		error: function(data){ 
			console.log(data);
		},
		complete: function(data){
			console.log(data);
			return data; 
		}
	});	
}

var update_team = function(team_id,properties){
	console.log(team_id);
	console.log(properties);
	
	$.ajax({
		url: "/teams/"+team_id,
		type: 'PUT',
		data: {team: properties},
		dataType: 'script',
		success: function(data){
			console.log(data);
		},
		error: function(data){ 
			console.log(data);
		},
		complete: function(data){
			console.log(data);
			return data; 
		}
	});	
}

;(function($, window, document, undefined) {
	var $win = $(window);
	var $doc = $(document);

	
	// Simple Templates
	function template(tpl, vars) {
		return tpl.replace(/{{([^}]+)}}/g, function(match, property) {
			var arr = property.split('.');
			var obj = vars[arr.shift()];

			while(arr.length > 0 && typeof obj === 'object') {
				obj = obj[arr.shift()];
			}

			return typeof obj === 'undefined' ? match : obj;
		});
	};

	// Leading Zero
	function leadingZero(number) {
		return number < 10 ? '0' + number : '' + number;
	};

	$doc.ready(function() {

		// 		// Scroll To
		// $('[data-scroll-to]').on('click', function(event) {
		// 	event.preventDefault();

		// 	var target = $(this).data('scroll-to');

		// 	$('html, body').animate({
		// 		scrollTop: $(target).offset().top
		// 	}, 500);
		// });

		// // Button Collapse Form
		// $('.btn-collapse-form').bind('click', function(event) {
		// 	event.preventDefault();
		// 	$(this).hide();
		// });

		// // Modal Fix
		// $('.header [data-toggle="modal-alt"]').on('click', function(event) {
		// 	event.preventDefault();

		// 	var target = $(this).attr('href');

		// 	if(!$('.modal-backdrop').length) {
		// 		$(target).modal('show');
		// 		return;
		// 	}

		// 	$('.modal').modal('hide');
		// 	setTimeout(function() {
		// 		$(target).modal('show');
		// 	}, 400);
		// });

		// // Autocomplete
		// $('.select-autocomplete').each(function(index, el) {
		// 	var placeholderText = $(this).data('placeholder');
		// 	$(this).fastselect({
		// 		choiceRemoveClass: 'ico-remove btn-remove',
		// 		placeholder: placeholderText
		// 	});
		// });

		$(".team-page-name,.team-page-description").focusout(function(){
			var target = $(this).parent();
			console.log(target);
			var team_id = target.data('team-id');
			console.log("team_id: " + team_id);
			update_team(team_id,{name: target.find(".team-page-name")[0].innerText, description: target.find(".team-page-description")[0].innerText});
		});

		
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

		// Change Class
		$('[data-change-class]').on('click', function(event) {
			event.preventDefault();

			var cl = $(this).data('change-class');
			var $target = $($(this).attr('href'));

			$target.attr('class', cl);
		});

		// Teams Sortable
		var delay = $win.width() < 768 ? 300 : 0;

		$('.teams-sortable').sortable({
			items: '.team-sortable',
			delay: delay,
			revert: 300
		});

		// Create Team
		var newTeamsCount = 0;

		$('.teams .team-create').on('click', function(event) {
			event.preventDefault();
            // console.log(1);
            var tpl = $($(this).attr('href')).html();
            var image_id = Math.round(Math.random() * 18);
            var image_name = "team"+(image_id + 1);
            var $team = $(template(tpl, {
            	image: team_images[image_id]
            }));

            $(this).closest('.team').before($team);

            $(this).closest('.teams-sortable').sortable('refresh');
            var team_created = false;

            $team.find('.team-title').focus().on('blur keydown', function(event) {
            	if (event.keyCode === 13 || event.type === 'blur') {
            		$(this).removeAttr('contentEditable');
					// console.log(2);
					if ($(this).html() == '') {
						$(this).html('Team ' + leadingZero(newTeamsCount + 1));
						newTeamsCount++;
					};

					if(team_created == false){
						create_team({name: $(this).html(),image: image_name },$(this));
						console.log("------");
						team_created = true
					}

				};

			});

            teamDroppable($team);
        });

		// Teams Slider
		var $teamsSlider = $('.teams-slider .teams-slides').owlCarousel({
			loop: false,
			items: 5,
			nav: true,
			slideBy: 1,
			dotsEach: 1,
			navText: ['<i class="ico-prev"></i>', '<i class="ico-next"></i>'],
			responsive: {
				0: {
					items: 1
				},
				480: {
					items: 3
				},
				768: {
					items: 4
				},
				1024: {
					items: 5
				}
			}
		});

		$teamsSlider.on('refreshed.owl.carousel', function(event) {
			$teamsSlider.trigger('to.owl.carousel', event.item.count - $teamsSlider.find('.owl-item.active').length);
		});

		$teamsSlider.on('translated.owl.carousel', function(event) {
			var $teamNew = $(this).find('.team-new');
			var team_created = false;
			
			$teamNew.find('.team-title').focus().on('blur keydown', function(event) {
				
				if (event.keyCode === 13 || event.type === 'blur') {
					$(this).removeAttr('contentEditable');
					$(this).closest('.team').removeClass('team-new');

					if ($(this).html() == '') {
						$(this).html('Team ' + leadingZero(newTeamsCount + 1));
						newTeamsCount++;
					};

					if(team_created == false){
						create_team({name: $(this).html(),image: $(this).closest('.team').data('image')},$(this));
						console.log("+++++");
						team_created = true
					};
				};

			});

			teamDroppable($teamNew);
		});

		$('.teams-create .team-create').on('click', function(event) {
			event.preventDefault();

			var tpl = $($(this).attr('href')).html();

			var image_id = Math.round(Math.random() * 8);
			var image_name = "team"+(image_id + 1);
			var $team = template(tpl, {
				image: team_images[image_id],
				image_name: image_name
			});

			$teamsSlider.trigger('add.owl.carousel', $team);
			$teamsSlider.trigger('refresh.owl.carousel');
		});

		// Team Droppable
		function teamDroppable(that) {
			var that_id = $(that).find('a.team-inner').attr('href').match(/\d+/);
			that_id = that_id ? that_id[0] : 0;
			var accept = $(that).data('accept') + ':not(.g-'+that_id+')';

			$(that).droppable({
				accept: accept,
				hoverClass: 'team-highlighted',
				over: function(event, ui) {
					ui.draggable.addClass('user-draggable-over');
				},
				out: function(event, ui) {
					ui.draggable.removeClass('user-draggable-over');
				},
				deactivate: function(event, ui) {
					ui.draggable.removeClass('user-draggable-over');
				},
				drop: function(event, ui) {
					
					$(that).addClass('team-dropped');
					ui.draggable.addClass('user-dropped g-' + that_id);

					setTimeout(function() {
						ui.draggable.removeAttr('style');
					}, 400);

					setTimeout(function() {
						$(that).removeClass('team-dropped');
						ui.draggable.removeClass('user-dropped');
					}, 1000);
					var user_id = ui.draggable.parents('li.user-alt').attr('id');
					add_profile_to_team(user_id,that_id);
					$(that).find('.team-count').text(parseInt($(that).find('.team-count').text()) + 1).css('color','#fff');
					if(!($(that).find('.team-count').hasClass('team-count-backet'))){
						var backet = $('.team-count-backet');
						backet.text(parseInt(backet.text()) + 1).css('color','#fff');											
					}
				}
			});
		};

		$('.team-droppable').each(function() {
			teamDroppable(this);
		});

		$('.teams-create .team-droppable').on('drop', function(event) {
			$(this).find('.team-create').trigger('click');
		});

		// User Draggable
		function userDraggable($items) {
			$items.draggable({
				revert: 'invalid',
				stop: function(event, ui) {
					$(this).removeClass('user-draggable-over');
				},
			});
		};

		userDraggable($('.user-draggable'));

		// User Groups
		$('.users').on('click', '.user-alt .user-groups', function(event) {
			event.stopPropagation();
		});

		// Create User Group
		$('.users').on('click', '.user-alt .user-create-group', function(event) {
			event.preventDefault();

			var tpl = $($(this).data('template')).html();
			var profile_id = $(this).data('profile');
			var $userGroup = $(template(tpl, {
				user: $(this).closest('.user-alt').index(),
				group: $(this).closest('li').index()
			}));

			$(this).closest('li').before($userGroup);
			team_created = false
			setTimeout(function() {
				$userGroup.find('label').focus().on('blur keydown', function(event) {
					if (event.keyCode === 13 || event.type === 'blur') {
						$(this).removeAttr('contentEditable');
						$(this).siblings('input').prop('disabled', false);

						if ($(this).html() == '') {
							$(this).html('Team ' + leadingZero(newTeamsCount + 1));
							newTeamsCount++;
						};
						
						if(team_created == false){
							create_team({name: $(this).html(),image: "team1" ,team_profiles_attributes: {profile_id: profile_id}},$(this));
							console.log("------");
							team_created = true
							$(this).addClass("add-profile");
							$(this).attr('data-profile',profile_id);
							// $(this).attr('data-team',);
						}
					};
				});
			}, 100);
		});

		// Add User To Group
		$('.users').on('click', '.add-profile', function(event) {
			// event.preventDefault();
			var team_id = $(this).data('team');
			var profile_id = $(this).data('profile');
			var action = $(this).siblings('input[type=checkbox]').is(':checked');
			var menu_backet =$("#"+$(this).data('backet'));
			console.log("Add User To Group: " + action);
			teams_count = $('.team-count-'+team_id);
			
			if(action == true){
				remove_profile_from_team(profile_id,team_id);
				teams_count.text(parseInt(teams_count.text()) - 1).css('color','#fff');

				if(!(teams_count.hasClass('team-count-backet'))){
					var top_backet = $('.team-count-backet');
					top_backet.text(parseInt(top_backet.text()) - 1).css('color','#fff');											
				}

			}else{
				add_profile_to_team(profile_id,team_id);
				teams_count.text(parseInt(teams_count.text()) + 1).css('color','#fff');	

				if(!(teams_count.hasClass('team-count-backet'))){
					var top_backet = $('.team-count-backet');
					top_backet.text(parseInt(top_backet.text()) + 1).css('color','#fff');											
				}
				if(menu_backet && !menu_backet.is(':checked')){
					menu_backet.each(function(){ this.checked = true; });
				}
			}
		});


		// User Messages
		$('.users').on('click', '.user-alt .user-message', function(event) {
			event.preventDefault();

			$(this).closest('.user-alt').find('.user-expand').fadeIn(300);
			$(this).closest('.user-alt').siblings().find('.user-expand').hide();
		});

		$('.users').on('click', '.user-alt .messages-close', function(event) {
			event.preventDefault();

			$(this).closest('.user-expand').fadeOut(300);
		});

		// $('.users, .section-team-page, .section-inbox').on('submit', '.form-message form', function(event) {
			$('.users, .section-team-page, .section-inbox').on('submit', '.form', function(event) {
				event.preventDefault();

				var $target = $($(this).attr('action'));
				var tpl = $('#message-template').html();

				var avatar = $(this).find('.field-message-avatar').val();
				var author = $(this).find('.field-message-author').val();
				var content = $(this).find('.field-message-content').val();

				content = '<p>' + content.replace(new RegExp('\n\n', 'g'), '</p><p>').replace(new RegExp('\n', 'g'), '<br>') + '</p>';

				if (content !== '') {
					var $message = $(template(tpl, {
						avatar: avatar,
						author: author,
						content: content
					}));

					$target.append($message.fadeIn(300));
					$(this).find('.field-message-content').val('');
				};
			});

		// User Touch
		$('.users').on('touchstart', '.user-alt', function(event) {
			$(this).addClass('user-touch').siblings().removeClass('user-touch');
		});

		// Infinite Scroll
		var $infinite = $('.infinite-scroll');
		var loading = false;

		if ($infinite.length) {
			$win.on('scroll.infiniteScroll', function(event) {
				var sectionBottom = $infinite.offset().top + $infinite.outerHeight();

				if ($win.scrollTop() + $win.height() > sectionBottom + 100) {
					var nextPageHref = $infinite.data('src');

					if(loading) {
						return;
					};

					loading = true;
					$infinite.addClass('infinite-loading')

					loadPage(nextPageHref)
					.success(function(response) {
						$infinite.data('src', nextPageHref.replace(/\d+/, function(match) {

							return parseInt(match) + 1;
						}));

						var $content = $(response);

						userDraggable($content.find('.user-draggable'));

						$infinite.append($content);
					})
					.error(function() {
						hasNextPage = false;

						$win.off('scroll.infiniteScroll');
					})
					.always(function() {
						loading = false;
						$infinite.removeClass('infinite-loading')
					});
				}
			}).scroll();
		};

		function loadPage(href) {
			return $.ajax({
				url: href,
				type: 'get'
			});
		};

		// Sticky Item
		$('.sticky-wrapper').each(function(index, el) {
			var $this = $(this);
			var $sticky = $this.find('.sticky-item');

			$win.on('scroll', function(event) {
				if ($win.scrollTop() > $this.offset().top) {
					$sticky.addClass('sticky-fixed');
				} else {
					$sticky.removeClass('sticky-fixed');
				};
			});
		});

		// Checkbox
		$('.checkbox-group').on('change', function(event) {
			var $group = $($(this).data('group'));

			$group.prop('checked', this.checked);
		});

		// Section Inbox
		$('.conversation > a, .conversation-compose > a').on('click', function(event) {
			event.preventDefault();

			$(this).closest('.section-inbox').addClass('has-selected');
		});

		$('.section-inbox .section-back').on('click', function(event) {
			event.preventDefault();

			$(this).closest('.section-inbox').removeClass('has-selected');
		});

		// Change Image
		$('.change-image').on('click', function(event) {
			event.preventDefault();

			var src = $(this).find('img').first().attr('src');
			var $target = $($(this).attr('href'));
			var image_name = $(this).data('image');
			$("#user_image").val(image_name);

			$target.attr('src', src);
			var team_id = $target[0].id;
			update_team(team_id,{image: image_name});
		});

		// Mass Message
		$('.link-mass-message').on('click', function(event) {
			event.preventDefault();

			setTimeout(function() {
				$('body').one('click', function(event) {
					$('.section-team-page .section-head-close').trigger('click');
				});
			}, 500);
		});

		$('.section-team-page .form-message').on('click', function(event) {
			event.stopPropagation();
		});

		// Team Invites
		$('.tabs-invites .tab-pane input').on('input', function(event) {
			var allFilled = true;
			var $tabBtn = $(this).closest('.tabs-invites').find('.active a');

			$(this).closest('.tab-pane').find('input').each(function(index, el) {
				if ($(this).val() === '') {
					allFilled = false;
					return false;
				};
			});

			if (allFilled) {
				$tabBtn.addClass('team-filled');
			} else {
				$tabBtn.removeClass('team-filled');
			};
		});
	});
})(jQuery, window, document);
